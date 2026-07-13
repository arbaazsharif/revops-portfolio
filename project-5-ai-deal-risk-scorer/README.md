# Project 5: AI-Powered Deal Risk Scorer

## Project Overview
Novu Software's VP of Sales had no early warning system for deals going cold. 
By the time a deal was obviously dying, it was too late to save it. I built 
an AI-powered deal risk scorer that evaluates every live pipeline deal against 
five risk signals and automatically generates an executive briefing with 
specific recommended actions — before deals go dark.

**Tools used:** PostgreSQL, Python, Claude API

## How It Works
A Python script connects to the PostgreSQL database, pulls all 25 current 
pipeline deals, and scores each one against five weighted risk signals. The 
scores are then sent to the Claude API which generates a plain-English 
executive briefing with deal-specific recommendations for the VP of Sales.

## The Scoring Model
Each deal is scored out of 100 points across five signals:

| Signal | Max Points |
|---|---|
| Days stuck in current stage vs average | 30 |
| Rep win rate | 25 |
| Deal source (Inbound/Outbound/Referral) | 20 |
| Segment (SMB/Mid-Market/Enterprise) | 15 |
| Stage drop-off risk | 10 |

**Risk Ratings:**
- 0–30 → Low Risk
- 31–60 → Medium Risk
- 61–100 → High Risk

## Key Output
Running the scorer against 25 live pipeline deals surfaced 8 high-risk deals 
requiring immediate attention, including Marigold Ventures (91/100) and 
Hawthorne & Reed (88/100) — both stalled in late-stage with outbound sources 
and lower win-rate reps. Jordan Cole was flagged as carrying three high-risk 
deals simultaneously, triggering a recommended 1:1 coaching conversation.

## Files
- `deal_risk_scorer.py` — Main Python script (PostgreSQL + Claude API)
- `project5_current_deals_seed.sql` — 25 pipeline deals loaded into PostgreSQL
- `risk_score_output.txt` — Sample output from the scorer

## Demo
[▶️ Watch Demo Video](https://www.youtube.com/watch?v=5cdycenJkUY)
