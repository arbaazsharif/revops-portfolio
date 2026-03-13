# revops-portfolio
Revenue Operations portfolio projects — SQL, CRM analysis, and pipeline reporting

 ## Project: Lead Score Validator

### Problem:
I set up a lead scoring system that assigns points to each lead based on their profile, seniority, industry, and behaviour. If the scoring model is inaccurate, the sales team risks spending time and resources chasing the wrong customers, resulting in wasted effort and lost revenue. This project set out to answer one question: do high-scoring leads actually convert to customers at a higher rate than low-scoring ones?

### Approach:
I worked with a dataset of 318 manufacturing contacts imported into HubSpot CRM. I exported the data to a Postgres database and built a structured leads table. Using SQL in Beekeeper Studio, I analyzed conversion rates by score bucket and lead source to validate whether the scoring model accurately predicts which leads will convert.

### Findings:

Bucket Analysis

- Hot leads (65 total) converted at 52.3%
- Warm leads (85 total) converted at 8.2%
- Cold leads (150 total) converted at just 1.3%

The 40x gap between Hot and Cold leads validates that the scoring model is accurately identifying high-intent prospects.

Lead Source Analysis

- Paid Search: 19 leads, 42.1% conversion
- Referral: 15 leads, 40.0% conversion
- Trade Show: 9 leads, 33.3% conversion
- Email Campaign: 53 leads, 1.9% conversion
- Direct: 51 leads, 0.0% conversion

High volume channels are not necessarily high quality. Paid Search and Referral significantly outperformed larger channels despite smaller lead counts.

### Recommendations:
1. Sales should prioritize Hot leads first — they convert at 40x the rate of Cold leads
2. Marketing should investigate why Email Campaign and Direct traffic produce low conversion despite high volume
3. Paid Search and Referral deserve increased investment given their conversion efficiency
4. Cold leads should be placed into a long-term nurture sequence rather than active outreach


### SQL Queries

**Bucket Analysis**

SELECT 
  CASE 
    WHEN lead_score > 60 THEN 'Hot'
    WHEN lead_score > 30 THEN 'Warm'
    ELSE 'Cold'
  END AS bucket,
  COUNT(*) AS total,
  SUM(CASE WHEN deal_value > 0 THEN 1 ELSE 0 END) AS converted,
  ROUND(100.0 * SUM(CASE WHEN deal_value > 0 THEN 1 ELSE 0 END) / COUNT(*), 1) AS conversion_rate_pct
FROM leads
WHERE lead_score IS NOT NULL
GROUP BY bucket;


**Lead Source Analysis**

SELECT 
  lead_source,
  COUNT(*) AS total,
  SUM(CASE WHEN deal_value > 0 THEN 1 ELSE 0 END) AS converted,
  ROUND(100.0 * SUM(CASE WHEN deal_value > 0 THEN 1 ELSE 0 END) / COUNT(*), 1) AS conversion_rate_pct
FROM leads
WHERE lead_source IS NOT NULL
GROUP BY lead_source
ORDER BY conversion_rate_pct DESC;


### Tools Used:
- HubSpot CRM
- PostgreSQL
- Beekeeper Studio
- Google Sheets
