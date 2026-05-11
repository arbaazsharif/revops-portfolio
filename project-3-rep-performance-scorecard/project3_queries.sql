 -- ============================================================
-- Project 3: Rep Performance Scorecard Dashboard
-- Company: Novu Software (B2B SaaS)
-- ============================================================

CREATE schema IF NOT EXISTS novu;


DROP TABLE IF EXISTS novu.deals;
DROP TABLE IF EXISTS novu.reps;

CREATE TABLE novu.reps (

    rep_id         INT PRIMARY KEY, 
    rep_name       VARCHAR(100),
    hire_date      DATE, 
    annual_quota   INT, 
    region         VARCHAR(50)
);

INSERT INTO novu.reps VALUES 
(1, 'Marcus Allen',  '2022-03-14', 420000, 'East'),
(2, 'Priya Nair',    '2022-07-01', 400000, 'West'),
(3, 'Jordan Cole',   '2023-01-09', 380000, 'Central'),
(4, 'Sofia Reyes',   '2023-04-17', 400000, 'East'),
(5, 'Daniel Okafor', '2022-11-28', 360000, 'West');

-- ============================================================
-- TABLE 2: deals
-- ============================================================


CREATE TABLE novu.deals (

    deal_id            INT PRIMARY KEY,
    rep_id             INT REFERENCES novu.reps(rep_id),
    company_name       VARCHAR(150),
    deal_stage         VARCHAR(50),
    close_date         DATE, 
    amount             INT,
    deal_source        VARCHAR(50),
    loss_reason        VARCHAR(100),
    sales_cycle_days   INT,
    segment            VARCHAR(50)
);



INSERT INTO novu.deals VALUES
-- ── Marcus Allen (rep_id=1) | East | Quota: $420K ──────────
-- Strong performer. High win rate, closes mid-market well.
-- 9 Won, 4 Lost
(1,  1, 'Apex Digital',           'Closed Won',  '2024-01-18', 28000, 'Inbound',  NULL,           45, 'Mid-Market'),
(2,  1, 'Hartwell Group',         'Closed Won',  '2024-02-12', 14000, 'Outbound', NULL,           38, 'SMB'),
(3,  1, 'Crestline Solutions',    'Closed Won',  '2024-03-29', 36000, 'Referral', NULL,           62, 'Mid-Market'),
(4,  1, 'BluePeak Logistics',     'Closed Lost', '2024-04-15', 19000, 'Outbound', 'Budget',       55, 'SMB'),
(5,  1, 'Meridian Partners',      'Closed Won',  '2024-05-22', 42000, 'Inbound',  NULL,           71, 'Mid-Market'),
(6,  1, 'Vantage Tech',           'Closed Won',  '2024-07-08', 11000, 'Outbound', NULL,           33, 'SMB'),
(7,  1, 'Lakeshore Media',        'Closed Lost', '2024-08-19', 24000, 'Inbound',  'Competitor',   48, 'Mid-Market'),
(8,  1, 'Sterling Innovations',   'Closed Won',  '2024-10-02', 33000, 'Referral', NULL,           59, 'Mid-Market'),
(9,  1, 'Northgate Financial',    'Closed Won',  '2024-11-14', 18000, 'Inbound',  NULL,           41, 'SMB'),
(10, 1, 'Pinewood Consulting',    'Closed Lost', '2024-12-20', 21000, 'Outbound', 'Timing',       66, 'Mid-Market'),
(11, 1, 'Orion Brands',           'Closed Won',  '2025-02-11', 38000, 'Inbound',  NULL,           54, 'Mid-Market'),
(12, 1, 'Clearfield Systems',     'Closed Won',  '2025-04-03', 16000, 'Referral', NULL,           37, 'SMB'),
(13, 1, 'Ridgeway Corp',          'Closed Lost', '2025-06-18', 29000, 'Outbound', 'No Decision',  72, 'Mid-Market'),
 
-- ── Priya Nair (rep_id=2) | West | Quota: $400K ─────────────
-- Solid second. Inbound-driven, strong mid-market close rate.
-- 8 Won, 5 Lost
(14, 2, 'Cobalt Creative',        'Closed Won',  '2024-01-25', 12000, 'Inbound',  NULL,           31, 'SMB'),
(15, 2, 'Summit Analytics',       'Closed Won',  '2024-03-07', 34000, 'Inbound',  NULL,           58, 'Mid-Market'),
(16, 2, 'Flint & Co',             'Closed Lost', '2024-04-22', 17000, 'Outbound', 'Budget',       49, 'SMB'),
(17, 2, 'Pacific Growth Labs',    'Closed Won',  '2024-05-30', 26000, 'Referral', NULL,           44, 'Mid-Market'),
(18, 2, 'Westside Operations',    'Closed Lost', '2024-07-11', 9000,  'Outbound', 'Competitor',   36, 'SMB'),
(19, 2, 'Altair Dynamics',        'Closed Won',  '2024-08-25', 40000, 'Inbound',  NULL,           68, 'Mid-Market'),
(20, 2, 'Redwood Ventures',       'Closed Lost', '2024-09-18', 22000, 'Outbound', 'Timing',       53, 'Mid-Market'),
(21, 2, 'NovaTech Industries',    'Closed Won',  '2024-10-29', 15000, 'Inbound',  NULL,           39, 'SMB'),
(22, 2, 'Cascade Digital',        'Closed Won',  '2024-12-11', 31000, 'Referral', NULL,           61, 'Mid-Market'),
(23, 2, 'Brightfield Inc',        'Closed Lost', '2025-01-20', 13000, 'Outbound', 'Budget',       42, 'SMB'),
(24, 2, 'Harbor Point Group',     'Closed Won',  '2025-03-14', 37000, 'Inbound',  NULL,           65, 'Mid-Market'),
(25, 2, 'Quantum Retail',         'Closed Lost', '2025-05-08', 20000, 'Outbound', 'No Decision',  57, 'Mid-Market'),
(26, 2, 'Solaris Software',       'Closed Won',  '2025-06-27', 23000, 'Referral', NULL,           47, 'Mid-Market'),
 
-- ── Jordan Cole (rep_id=3) | Central | Quota: $380K ─────────
-- Struggling. Loses heavily to competitors. Needs coaching.
-- 6 Won, 7 Lost
(27, 3, 'Ironclad Ops',           'Closed Won',  '2024-02-08', 10000, 'Inbound',  NULL,           35, 'SMB'),
(28, 3, 'Delta Processing',       'Closed Lost', '2024-03-19', 27000, 'Outbound', 'Competitor',   61, 'Mid-Market'),
(29, 3, 'Granite Works',          'Closed Lost', '2024-04-30', 18000, 'Outbound', 'Competitor',   50, 'SMB'),
(30, 3, 'Ember Analytics',        'Closed Won',  '2024-06-12', 32000, 'Inbound',  NULL,           56, 'Mid-Market'),
(31, 3, 'Fox River Digital',      'Closed Lost', '2024-07-24', 14000, 'Outbound', 'Timing',       44, 'SMB'),
(32, 3, 'Beacon Capital',         'Closed Lost', '2024-08-30', 39000, 'Inbound',  'Competitor',   74, 'Mid-Market'),
(33, 3, 'Hillcrest Software',     'Closed Won',  '2024-10-15', 8000,  'Outbound', NULL,           29, 'SMB'),
(34, 3, 'Eastgate Media',         'Closed Lost', '2024-11-22', 25000, 'Outbound', 'Competitor',   67, 'Mid-Market'),
(35, 3, 'Aurora Systems',         'Closed Won',  '2025-01-08', 17000, 'Inbound',  NULL,           40, 'SMB'),
(36, 3, 'Bridgeway Consulting',   'Closed Lost', '2025-02-25', 30000, 'Outbound', 'Budget',       58, 'Mid-Market'),
(37, 3, 'Keystone Digital',       'Closed Won',  '2025-04-09', 22000, 'Referral', NULL,           48, 'Mid-Market'),
(38, 3, 'Lakewood Partners',      'Closed Lost', '2025-05-21', 11000, 'Outbound', 'Competitor',   37, 'SMB'),
(39, 3, 'Spectrum Data',          'Closed Won',  '2025-07-02', 28000, 'Inbound',  NULL,           52, 'Mid-Market'),
 
-- ── Sofia Reyes (rep_id=4) | East | Quota: $400K ────────────
-- Newer rep. Wins SMB consistently, struggles in mid-market.
-- 7 Won, 6 Lost
(40, 4, 'Trident Solutions',      'Closed Won',  '2024-02-20', 9000,  'Inbound',  NULL,           30, 'SMB'),
(41, 4, 'Maple Grove Tech',       'Closed Lost', '2024-03-31', 32000, 'Outbound', 'Timing',       69, 'Mid-Market'),
(42, 4, 'Foxwood Digital',        'Closed Won',  '2024-05-10', 13000, 'Inbound',  NULL,           36, 'SMB'),
(43, 4, 'Glenview Advisors',      'Closed Lost', '2024-06-18', 24000, 'Outbound', 'Budget',       55, 'Mid-Market'),
(44, 4, 'Pinnacle Ops',           'Closed Won',  '2024-07-29', 7000,  'Referral', NULL,           28, 'SMB'),
(45, 4, 'Whitewater Analytics',   'Closed Won',  '2024-09-10', 19000, 'Inbound',  NULL,           43, 'SMB'),
(46, 4, 'Copperview Corp',        'Closed Lost', '2024-10-22', 36000, 'Outbound', 'Competitor',   77, 'Mid-Market'),
(47, 4, 'Aspen Technologies',     'Closed Won',  '2024-11-30', 11000, 'Inbound',  NULL,           34, 'SMB'),
(48, 4, 'Thornfield Logistics',   'Closed Lost', '2025-01-14', 28000, 'Outbound', 'No Decision',  62, 'Mid-Market'),
(49, 4, 'Everest Digital',        'Closed Won',  '2025-02-28', 16000, 'Referral', NULL,           41, 'SMB'),
(50, 4, 'Riverview Partners',     'Closed Lost', '2025-04-11', 21000, 'Inbound',  'Budget',       50, 'Mid-Market'),
(51, 4, 'Cobblestone Media',      'Closed Won',  '2025-05-23', 14000, 'Inbound',  NULL,           38, 'SMB'),
(52, 4, 'Highland Software',      'Closed Lost', '2025-07-07', 33000, 'Outbound', 'Timing',       71, 'Mid-Market'),
 
-- ── Daniel Okafor (rep_id=5) | West | Quota: $360K ──────────
-- Solid performer. Consistent but loses budget-sensitive deals.
-- 8 Won, 5 Lost
(53, 5, 'Cedarwood Group',        'Closed Won',  '2024-01-30', 20000, 'Inbound',  NULL,           42, 'Mid-Market'),
(54, 5, 'Velocity Retail',        'Closed Lost', '2024-03-12', 15000, 'Outbound', 'Budget',       46, 'SMB'),
(55, 5, 'Ironwood Ventures',      'Closed Won',  '2024-04-24', 35000, 'Referral', NULL,           63, 'Mid-Market'),
(56, 5, 'Sandstone Media',        'Closed Won',  '2024-06-05', 12000, 'Inbound',  NULL,           33, 'SMB'),
(57, 5, 'Midpoint Digital',       'Closed Lost', '2024-07-16', 26000, 'Outbound', 'Budget',       57, 'Mid-Market'),
(58, 5, 'Crossroads Analytics',   'Closed Won',  '2024-08-27', 9000,  'Inbound',  NULL,           31, 'SMB'),
(59, 5, 'Elara Systems',          'Closed Won',  '2024-10-08', 38000, 'Referral', NULL,           67, 'Mid-Market'),
(60, 5, 'Foundry Tech',           'Closed Lost', '2024-11-19', 18000, 'Outbound', 'Budget',       51, 'SMB'),
(61, 5, 'Glacier Software',       'Closed Won',  '2025-01-22', 24000, 'Inbound',  NULL,           45, 'Mid-Market'),
(62, 5, 'Sterling Path Co',       'Closed Lost', '2025-03-05', 31000, 'Outbound', 'Competitor',   68, 'Mid-Market'),
(63, 5, 'Bluebell Analytics',     'Closed Won',  '2025-04-17', 16000, 'Inbound',  NULL,           39, 'SMB'),
(64, 5, 'Riverton Digital',       'Closed Won',  '2025-06-01', 29000, 'Referral', NULL,           55, 'Mid-Market'),
(65, 5, 'Ashford Operations',     'Closed Lost', '2025-07-15', 22000, 'Outbound', 'No Decision',  60, 'Mid-Market');


-- Win Rate Percentage per Rep

SELECT 
  r.rep_name,
  COUNT(*) AS total_deals,
  ROUND(
    COUNT(CASE WHEN deal_stage = 'Closed Won' THEN 1 END) * 100.0 / COUNT(*),
    1
) AS win_rate_pct

FROM novu.reps r 
JOIN novu.deals d ON r.rep_id = d.rep_id
GROUP BY r.rep_name
ORDER BY win_rate_pct DESC;


-- Total Revenue Closed Per Rep

SELECT 
  r.rep_name, 
  SUM (d.amount) AS total_revenue
FROM novu.reps r
JOIN novu.deals d ON r.rep_id = d.rep_id
WHERE deal_stage = 'Closed Won'
GROUP BY r.rep_name
ORDER BY total_revenue DESC;


-- Quota Attainment Per Rep

SELECT 
  r.rep_name,
  r.annual_quota,
  SUM(d.amount) AS total_revenue_closed,
  ROUND((SUM(d.amount) * 100.0/r.annual_quota),1) AS quota_attained_pct

FROM novu.reps r
JOIN novu.deals d ON r.rep_id = d.rep_id
WHERE deal_stage = 'Closed Won'
GROUP BY r.rep_name, r.annual_quota 
ORDER BY quota_attained_pct DESC;


-- Average Deal Size Per Rep

SELECT 
  r.rep_name,
  ROUND(AVG(d.amount), 1) AS avg_deal_size

FROM novu.reps r 
JOIN novu.deals d ON r.rep_id = d.rep_id
WHERE deal_stage = 'Closed Won'
GROUP BY r.rep_name
ORDER BY avg_deal_size DESC;


-- Loss Reason Breakdown Per Rep

SELECT 
  r.rep_name,
  d.loss_reason,
  COUNT(d.deal_stage) AS lost_deal_count

FROM novu.reps r
JOIN novu.deals d ON r.rep_id = d.rep_id
WHERE deal_stage = 'Closed Lost'
GROUP BY r.rep_name, d.loss_reason
ORDER BY r.rep_name, lost_deal_count DESC;

-- Win Rate by Deal Source

SELECT 
  d.deal_source,
  COUNT(*) AS total_deals,
  COUNT(CASE WHEN deal_stage = 'Closed Won'THEN 1 END) AS deals_won_per_source,
  ROUND(COUNT(CASE WHEN deal_stage = 'Closed Won'THEN 1 END)*100.0/COUNT(*),1) AS win_rate_pct

FROM novu.deals d
GROUP BY d.deal_source
ORDER BY win_rate_pct DESC;


-- Average Sales Cycle Per Rep

SELECT 
  r.rep_name,
  ROUND(AVG(d.sales_cycle_days),1) AS avg_sales_cycle_days

FROM novu.reps r
JOIN novu.deals d ON r.rep_id = d.rep_id
WHERE d.deal_stage = 'Closed Won'
GROUP BY r.rep_name
ORDER BY avg_sales_cycle_days ASC;


-- Monthly Closed-Won Revenue Trend

SELECT 
  TO_CHAR(d.close_date, 'YYYY-MM') AS month,
  COUNT(*) AS deals_closed,
  SUM(d.amount) AS total_revenue

FROM novu.deals d
WHERE deal_stage = 'Closed Won'
GROUP BY month
ORDER BY month ASC;


