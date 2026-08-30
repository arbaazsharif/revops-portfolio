"""
Project 6 - Step 5 (final): Generate a personalized re-engagement email
for each Hot/Warm deal using the Claude API.

Same request pattern as Apollo: one header carries auth (x-api-key),
one HTTP call per deal, JSON in, JSON out. The only new piece is the
"system" field, which tells Claude what role to play (a Megamation
rep) before we hand it the specific facts for one deal.

We deliberately skip Cold-tier deals - a real revival campaign
wouldn't spend outreach effort there, so neither should this script.
"""

import os
import csv
import time
import requests
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.getenv("ANTHROPIC_API_KEY")
ENDPOINT = "https://api.anthropic.com/v1/messages"
MODEL = "claude-sonnet-5"

SYSTEM_PROMPT = """You are a Business Development Representative at a company that sells \
maintenance management software (a CMMS platform) to facilities, manufacturing, \
property management, hospitality, and healthcare organizations.

Write a short re-engagement email (under 120 words) to a company whose deal \
went closed-lost. The email must:
- Reference the real reason the deal was lost, without being blunt about it
- Point to a specific, concrete reason to revisit the conversation now (use the \
  company data provided - growth, size, industry)
- Sound like a real rep wrote it: direct, low-pressure, no hype, no exclamation points
- End with a soft, single call to action (e.g. a 15-minute call)
- Output ONLY the email body. No subject line, no preamble, no signature block."""


def generate_email(deal: dict) -> str:
    growth_pct = round(float(deal["headcount_growth_12mo"]) * 100, 1) if deal["headcount_growth_12mo"] else "unknown"

    user_prompt = f"""Company: {deal['real_company_name']}
Industry: {deal['industry']}
Employee count: {deal['employee_count']}
Headcount growth (last 12 months): {growth_pct}%
Deal size lost: ${deal['amount']}
Reason we lost the deal: {deal['loss_reason']}
Revival tier: {deal['revival_tier']} ({deal['revival_score']} / 90)

Write the re-engagement email."""

    headers = {
        "x-api-key": API_KEY,
        "anthropic-version": "2023-06-01",
        "content-type": "application/json",
    }
    payload = {
        "model": MODEL,
        "max_tokens": 300,
        "system": SYSTEM_PROMPT,
        "messages": [{"role": "user", "content": user_prompt}],
    }

    response = requests.post(ENDPOINT, headers=headers, json=payload)
    if response.status_code != 200:
        print(f"    FAILED ({response.status_code}): {response.text[:200]}")
        return None

    return response.json()["content"][0]["text"].strip()


def main():
    if not API_KEY:
        raise SystemExit("ANTHROPIC_API_KEY not found. Add it to your .env file.")

    with open("scored_deals.csv", newline="") as f:
        deals = list(csv.DictReader(f))

    targets = [d for d in deals if d["revival_tier"] in ("Hot", "Warm")]
    targets.sort(key=lambda d: int(d["revival_score"]), reverse=True)

    print(f"Generating emails for {len(targets)} Hot/Warm deals (skipping Cold)...\n")

    with open("generated_emails.md", "w") as out:
        out.write("# Project 6 - Generated Re-engagement Emails\n\n")

        for i, deal in enumerate(targets, start=1):
            print(f"[{i}/{len(targets)}] {deal['real_company_name']} ({deal['revival_tier']}, {deal['revival_score']} pts)")
            email = generate_email(deal)

            out.write(f"## {deal['real_company_name']} — {deal['revival_tier']} ({deal['revival_score']} pts)\n")
            out.write(f"*Lost to: {deal['loss_reason']} | Deal size: ${deal['amount']} | Industry: {deal['industry']}*\n\n")
            out.write(f"{email if email else '[GENERATION FAILED]'}\n\n---\n\n")

            time.sleep(0.5)

    print("\nDone. Saved to generated_emails.md")


if __name__ == "__main__":
    main()
