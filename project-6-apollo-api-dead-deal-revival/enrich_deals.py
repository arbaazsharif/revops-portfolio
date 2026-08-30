"""
Project 6 - Step 3: Enrich all 27 closed-lost deals with live Apollo data.

Pipeline:
  1. Load the deals (fake company names, real deal data).
  2. Load the name -> real domain mapping.
  3. For each deal, join on company_name to get a real domain.
  4. Call Apollo's Organization Enrichment endpoint for that domain.
  5. Pull out the fields that matter for revival scoring (Step 4, next).
  6. Save one row per deal to enriched_deals.csv.

This is a BATCH version of test_connection.py — same endpoint, same
auth, just looped with error handling so one bad lookup doesn't kill
the whole run.
"""

import os
import csv
import time
import requests
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.getenv("APOLLO_API_KEY")
ENRICH_ENDPOINT = "https://api.apollo.io/api/v1/organizations/enrich"


def load_domain_map(path: str) -> dict:
    mapping = {}
    with open(path, newline="") as f:
        for row in csv.DictReader(f):
            mapping[row["fake_company_name"]] = {
                "real_company_name": row["real_company_name"],
                "real_domain": row["real_domain"],
            }
    return mapping


def enrich_company(domain: str) -> dict | None:
    headers = {"accept": "application/json", "x-api-key": API_KEY}
    params = {"domain": domain}
    response = requests.get(ENRICH_ENDPOINT, headers=headers, params=params)

    if response.status_code != 200:
        print(f"    FAILED ({response.status_code}) for domain {domain}")
        return None

    return response.json().get("organization")


def main():
    if not API_KEY:
        raise SystemExit("APOLLO_API_KEY not found. Add it to your .env file.")

    domain_map = load_domain_map("company_domain_map.csv")

    with open("closed_lost_deals.csv", newline="") as f:
        deals = list(csv.DictReader(f))

    results = []
    print(f"Enriching {len(deals)} closed-lost deals...\n")

    for i, deal in enumerate(deals, start=1):
        fake_name = deal["company_name"]
        mapped = domain_map.get(fake_name)

        if not mapped:
            print(f"[{i}/{len(deals)}] SKIP - no domain mapping for '{fake_name}'")
            continue

        domain = mapped["real_domain"]
        print(f"[{i}/{len(deals)}] {fake_name} -> {mapped['real_company_name']} ({domain})")

        org = enrich_company(domain)

        row = {
            "deal_id": deal["deal_id"],
            "company_name": fake_name,
            "real_company_name": mapped["real_company_name"],
            "domain": domain,
            "amount": deal["amount"],
            "close_date": deal["close_date"],
            "loss_reason": deal["loss_reason"],
            "segment": deal["segment"],
        }

        if org:
            row.update({
                "industry": org.get("industry"),
                "employee_count": org.get("estimated_num_employees"),
                "headcount_growth_6mo": org.get("organization_headcount_six_month_growth"),
                "headcount_growth_12mo": org.get("organization_headcount_twelve_month_growth"),
                "latest_funding_stage": org.get("latest_funding_stage"),
                "total_funding": org.get("total_funding"),
                "technology_count": len(org.get("technology_names") or []),
                "enrichment_status": "success",
            })
        else:
            row["enrichment_status"] = "failed"

        results.append(row)
        time.sleep(0.5)  # be polite to the API, avoid rate limiting

    fieldnames = [
        "deal_id", "company_name", "real_company_name", "domain", "amount",
        "close_date", "loss_reason", "segment", "industry", "employee_count",
        "headcount_growth_6mo", "headcount_growth_12mo", "latest_funding_stage",
        "total_funding", "technology_count", "enrichment_status",
    ]
    with open("enriched_deals.csv", "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(results)

    succeeded = sum(1 for r in results if r.get("enrichment_status") == "success")
    print(f"\nDone. {succeeded}/{len(results)} enriched successfully.")
    print("Saved to enriched_deals.csv")


if __name__ == "__main__":
    main()
