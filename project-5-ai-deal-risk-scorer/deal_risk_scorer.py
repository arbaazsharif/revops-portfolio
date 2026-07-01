import anthropic
import psycopg2

# ── Database connection ──────────────────────────────────────
conn = psycopg2.connect(
    host="localhost",
    database="postgres",
    user="postgres",
    password="Aariz1711142207$$",
    port=5432
)
cursor = conn.cursor()

# ── Rep win rates from Project 3 ─────────────────────────────
rep_win_rates = {
    1: 69.2,  # Marcus Allen
    2: 61.5,  # Priya Nair
    3: 46.2,  # Jordan Cole
    4: 53.8,  # Sofia Reyes
    5: 61.5   # Daniel Okafor
}

rep_names = {
    1: 'Marcus Allen',
    2: 'Priya Nair',
    3: 'Jordan Cole',
    4: 'Sofia Reyes',
    5: 'Daniel Okafor'
}

# ── Average days per stage from Project 4 ───────────────────
avg_days_per_stage = {
    'Lead': 4.6,
    'Discovery Call': 6.9,
    'Demo Booked': 11.6,
    'Proposal Sent': 14.3,
    'Negotiation': 17.1
}

# ── Scoring functions ────────────────────────────────────────
def score_days_in_stage(stage, days):
    avg = avg_days_per_stage.get(stage, 10)
    over = days - avg
    if over <= 0:
        return 0
    elif over <= 5:
        return 10
    elif over <= 10:
        return 20
    else:
        return 30

def score_rep(rep_id):
    win_rate = rep_win_rates.get(rep_id, 50)
    if win_rate >= 65:
        return 0
    elif win_rate >= 55:
        return 8
    elif win_rate >= 45:
        return 16
    else:
        return 25

def score_source(source):
    if source == 'Referral':
        return 0
    elif source == 'Inbound':
        return 5
    else:
        return 20

def score_segment(segment):
    if segment == 'SMB':
        return 0
    elif segment == 'Mid-Market':
        return 10
    else:
        return 15

def score_stage(stage):
    mapping = {
        'Lead': 0,
        'Discovery Call': 0,
        'Demo Booked': 3,
        'Proposal Sent': 7,
        'Negotiation': 10
    }
    return mapping.get(stage, 0)

def get_risk_rating(score):
    if score <= 30:
        return 'LOW'
    elif score <= 60:
        return 'MEDIUM'
    else:
        return 'HIGH'

# ── Fetch all current deals ──────────────────────────────────
cursor.execute("""
    SELECT deal_id, company_name, rep_id, segment,
           deal_source, amount, current_stage, days_in_current_stage
    FROM novu.current_deals
    ORDER BY deal_id
""")
deals = cursor.fetchall()

# ── Score each deal and collect results ──────────────────────
scored_deals = []

for deal in deals:
    deal_id, company, rep_id, segment, source, amount, stage, days = deal

    s1 = score_days_in_stage(stage, days)
    s2 = score_rep(rep_id)
    s3 = score_source(source)
    s4 = score_segment(segment)
    s5 = score_stage(stage)
    total = s1 + s2 + s3 + s4 + s5
    rating = get_risk_rating(total)

    scored_deals.append({
        'deal_id': deal_id,
        'company': company,
        'rep': rep_names[rep_id],
        'segment': segment,
        'source': source,
        'amount': amount,
        'stage': stage,
        'days': days,
        'score': total,
        'rating': rating
    })

# ── Build summary for Claude API ─────────────────────────────
high_risk = [d for d in scored_deals if d['rating'] == 'HIGH']
medium_risk = [d for d in scored_deals if d['rating'] == 'MEDIUM']
low_risk = [d for d in scored_deals if d['rating'] == 'LOW']

summary_text = "DEAL RISK SCORING SUMMARY\n"
summary_text += f"Total deals scored: {len(scored_deals)}\n"
summary_text += f"High Risk: {len(high_risk)} | Medium Risk: {len(medium_risk)} | Low Risk: {len(low_risk)}\n\n"

summary_text += "HIGH RISK DEALS:\n"
for d in high_risk:
    summary_text += f"- {d['company']} | Rep: {d['rep']} | {d['segment']} | {d['source']} | Stage: {d['stage']} | Days in stage: {d['days']} | Score: {d['score']}/100\n"

summary_text += "\nMEDIUM RISK DEALS:\n"
for d in medium_risk:
    summary_text += f"- {d['company']} | Rep: {d['rep']} | {d['segment']} | {d['source']} | Stage: {d['stage']} | Days in stage: {d['days']} | Score: {d['score']}/100\n"

# ── Send to Claude API for narrative ─────────────────────────
client = anthropic.Anthropic(api_key="YOUR_API_KEY_HERE")

message = client.messages.create(
    model="claude-sonnet-4-6",
    max_tokens=1024,
    messages=[
        {
            "role": "user",
            "content": f"""You are a Revenue Operations analyst at Novu Software.

Based on the deal risk scores below, write a concise executive briefing (3-4 paragraphs) 
for the VP of Sales. Identify which deals need immediate attention, explain why they are 
at risk, and recommend specific actions for each high risk deal.

{summary_text}

Be direct and specific. Use the company names and rep names in your response."""
        }
    ]
)

# ── Print results ─────────────────────────────────────────────
print("=" * 60)
print("NOVU SOFTWARE — AI DEAL RISK SCORER")
print("Powered by Claude API")
print("=" * 60)
print()
print(f"{'DEAL':<25} {'REP':<15} {'STAGE':<18} {'DAYS':>5} {'SCORE':>6} {'RISK':<8}")
print("-" * 80)
for d in scored_deals:
    print(f"{d['company']:<25} {d['rep']:<15} {d['stage']:<18} {d['days']:>5} {d['score']:>6} {d['rating']:<8}")

print()
print("=" * 60)
print("AI EXECUTIVE BRIEFING")
print("=" * 60)
print()
print(message.content[0].text)

cursor.close()
conn.close()