-- ============================================================
-- Project 5: AI-Powered Deal Risk Scorer
-- Table: novu.current_deals
-- Live pipeline deals to be scored for risk.
-- 25 deals total: 20 SMB/Mid-Market + 5 Enterprise
-- ============================================================

DROP TABLE IF EXISTS novu.current_deals;

CREATE TABLE novu.current_deals (
    deal_id               INT PRIMARY KEY,
    company_name          VARCHAR(150),
    rep_id                INT REFERENCES novu.reps(rep_id),
    segment               VARCHAR(50),   -- SMB | Mid-Market | Enterprise
    deal_source           VARCHAR(50),   -- Inbound | Outbound | Referral
    amount                INT,
    current_stage         VARCHAR(50),   -- Lead | Discovery Call | Demo Booked | Proposal Sent | Negotiation
    days_in_current_stage INT            -- How long the deal has sat in its current stage
);

INSERT INTO novu.current_deals VALUES
(1, 'Brightline Media', 1, 'SMB', 'Inbound', 9000, 'Lead', 4),
(2, 'Vertex Capital Group', 1, 'Mid-Market', 'Referral', 28000, 'Proposal Sent', 12),
(3, 'Northfield Logistics', 2, 'SMB', 'Inbound', 12000, 'Discovery Call', 7),
(4, 'Solace Wellness Co', 2, 'Mid-Market', 'Outbound', 24000, 'Negotiation', 23),
(5, 'Cinderpath Analytics', 3, 'Mid-Market', 'Outbound', 27000, 'Proposal Sent', 22),
(6, 'Maritime Industrial', 3, 'SMB', 'Outbound', 13000, 'Demo Booked', 16),
(7, 'Goldwell Partners', 3, 'Mid-Market', 'Outbound', 31000, 'Negotiation', 28),
(8, 'Thistledown Group', 4, 'SMB', 'Inbound', 8000, 'Demo Booked', 11),
(9, 'Anchorpoint Systems', 4, 'Mid-Market', 'Outbound', 22000, 'Proposal Sent', 19),
(10, 'Ravenscourt Holdings', 5, 'Mid-Market', 'Referral', 26000, 'Negotiation', 14),
(11, 'Pinehollow Ventures', 5, 'SMB', 'Inbound', 7000, 'Lead', 5),
(12, 'Brackenridge Tech', 1, 'SMB', 'Outbound', 10000, 'Discovery Call', 9),
(13, 'Stonebridge Capital', 2, 'Mid-Market', 'Inbound', 25000, 'Demo Booked', 13),
(14, 'Millrace Solutions', 3, 'SMB', 'Referral', 6000, 'Lead', 3),
(15, 'Fernwood Industries', 4, 'Mid-Market', 'Outbound', 29000, 'Negotiation', 26),
(16, 'Coppergate Brands', 5, 'SMB', 'Outbound', 14000, 'Proposal Sent', 17),
(17, 'Sablewood Consulting', 1, 'Mid-Market', 'Inbound', 21000, 'Discovery Call', 6),
(18, 'Ironvale Manufacturing', 2, 'SMB', 'Referral', 9000, 'Demo Booked', 12),
(19, 'Whitmoor Financial', 3, 'Mid-Market', 'Inbound', 23000, 'Demo Booked', 14),
(20, 'Larkspur Digital', 4, 'SMB', 'Referral', 11000, 'Negotiation', 15),
(21, 'Cobblestone Retail', 1, 'Enterprise', 'Outbound', 95000, 'Negotiation', 31),
(22, 'Hawthorne & Reed', 3, 'Enterprise', 'Outbound', 78000, 'Proposal Sent', 26),
(23, 'Driftwood Media Group', 2, 'Enterprise', 'Referral', 110000, 'Negotiation', 15),
(24, 'Stillwater Logistics', 5, 'Enterprise', 'Inbound', 65000, 'Demo Booked', 15),
(25, 'Marigold Ventures', 4, 'Enterprise', 'Outbound', 88000, 'Negotiation', 35);
