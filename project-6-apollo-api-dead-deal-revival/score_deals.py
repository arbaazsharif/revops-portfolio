"""
Project 6 - Step 4: Score each enriched deal for revival potential.

Three signals, each independently justifiable:
  1. loss_reason   (from CRM)    - why did we actually lose this deal?
  2. headcount growth, 12mo (Apollo) - is the company scaling right now?
  3. employee_count (Apollo)     - is this still a realistic size to sell to?

Each signal contributes points on its own scale. We sum them into one
score (max 90), then bucket into Hot / Warm / Cold so the output is
something a rep could actually act on, not just a raw number.
"""

import csv

LOSS_REASON_POINTS = {
    "Timing": 40,
    "Budget": 30,
    "No Decision": 20,
    "Competitor": 10,
}


def score_loss_reason(reason: str) -> int:
    return LOSS_REASON_POINTS.get(reason, 0)


def score_headcount_growth(growth_12mo) -> int:
    if growth_12mo in ("", None):
        return 0
    g = float(growth_12mo)
    if g > 0.05:
        return 30
    elif g > 0.02:
        return 20
    elif g >= 0:
        return 10
    else:
        return 0


def score_employee_count(employee_count) -> int:
    if employee_count in ("", None):
        return 0
    n = int(float(employee_count))
    if n < 5000:
        return 20
    elif n < 50000:
        return 10
    else:
        return 0


def bucket(total_score: int) -> str:
    if total_score >= 60:
        return "Hot"
    elif total_score >= 35:
        return "Warm"
    else:
        return "Cold"


def main():
    with open("enriched_deals.csv", newline="") as f:
        rows = list(csv.DictReader(f))

    scored = []
    for row in rows:
        loss_pts = score_loss_reason(row["loss_reason"])
        growth_pts = score_headcount_growth(row["headcount_growth_12mo"])
        size_pts = score_employee_count(row["employee_count"])
        total = loss_pts + growth_pts + size_pts

        scored.append({
            **row,
            "loss_reason_points": loss_pts,
            "headcount_growth_points": growth_pts,
            "employee_size_points": size_pts,
            "revival_score": total,
            "revival_tier": bucket(total),
        })

    # highest revival potential first
    scored.sort(key=lambda r: r["revival_score"], reverse=True)

    fieldnames = list(rows[0].keys()) + [
        "loss_reason_points", "headcount_growth_points",
        "employee_size_points", "revival_score", "revival_tier",
    ]
    with open("scored_deals.csv", "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(scored)

    tier_counts = {"Hot": 0, "Warm": 0, "Cold": 0}
    for r in scored:
        tier_counts[r["revival_tier"]] += 1

    print(f"Scored {len(scored)} deals.")
    print(f"Hot: {tier_counts['Hot']}  |  Warm: {tier_counts['Warm']}  |  Cold: {tier_counts['Cold']}\n")
    print("Top 5 revival candidates:")
    for r in scored[:5]:
        print(f"  {r['revival_score']:>3} pts [{r['revival_tier']:>4}] - {r['real_company_name']} "
              f"(lost to {r['loss_reason']}, ${r['amount']})")

    print("\nSaved full results to scored_deals.csv")


if __name__ == "__main__":
    main()
