-- ============================================================
-- Project 4: Full Funnel Attribution Model
-- Table: novu.funnel_events
-- Tracks each deal's journey through the sales pipeline.
-- One row per stage per deal.
-- ============================================================

DROP TABLE IF EXISTS novu.funnel_events;

CREATE TABLE novu.funnel_events (
    event_id      INT PRIMARY KEY,
    deal_id       INT REFERENCES novu.deals(deal_id),
    stage_name    VARCHAR(50),   -- Lead, Discovery Call, Demo Booked, Proposal Sent, Negotiation
    entry_date    DATE,          -- When the deal entered this stage
    exit_date     DATE,          -- When it left (or closed)
    days_in_stage INT,           -- exit_date - entry_date
    outcome       VARCHAR(50)    -- Advanced | Dropped Off | Closed Won
);

INSERT INTO novu.funnel_events VALUES
(1, 1, 'Lead', '2023-12-04', '2023-12-08', 4, 'Advanced'),
(2, 1, 'Discovery Call', '2023-12-08', '2023-12-13', 5, 'Advanced'),
(3, 1, 'Demo Booked', '2023-12-13', '2023-12-22', 9, 'Advanced'),
(4, 1, 'Proposal Sent', '2023-12-22', '2024-01-02', 11, 'Advanced'),
(5, 1, 'Negotiation', '2024-01-02', '2024-01-18', 16, 'Closed Won'),
(6, 2, 'Lead', '2024-01-05', '2024-01-08', 3, 'Advanced'),
(7, 2, 'Discovery Call', '2024-01-08', '2024-01-13', 5, 'Advanced'),
(8, 2, 'Demo Booked', '2024-01-13', '2024-01-21', 8, 'Advanced'),
(9, 2, 'Proposal Sent', '2024-01-21', '2024-01-31', 10, 'Advanced'),
(10, 2, 'Negotiation', '2024-01-31', '2024-02-12', 12, 'Closed Won'),
(11, 3, 'Lead', '2024-01-27', '2024-02-01', 5, 'Advanced'),
(12, 3, 'Discovery Call', '2024-02-01', '2024-02-08', 7, 'Advanced'),
(13, 3, 'Demo Booked', '2024-02-08', '2024-02-20', 12, 'Advanced'),
(14, 3, 'Proposal Sent', '2024-02-20', '2024-03-07', 16, 'Advanced'),
(15, 3, 'Negotiation', '2024-03-07', '2024-03-29', 22, 'Closed Won'),
(16, 4, 'Lead', '2024-02-20', '2024-02-27', 7, 'Advanced'),
(17, 4, 'Discovery Call', '2024-02-27', '2024-03-08', 10, 'Advanced'),
(18, 4, 'Demo Booked', '2024-03-08', '2024-03-25', 17, 'Advanced'),
(19, 4, 'Proposal Sent', '2024-03-25', '2024-04-15', 21, 'Dropped Off'),
(20, 5, 'Lead', '2024-03-12', '2024-03-18', 6, 'Advanced'),
(21, 5, 'Discovery Call', '2024-03-18', '2024-03-27', 9, 'Advanced'),
(22, 5, 'Demo Booked', '2024-03-27', '2024-04-10', 14, 'Advanced'),
(23, 5, 'Proposal Sent', '2024-04-10', '2024-04-28', 18, 'Advanced'),
(24, 5, 'Negotiation', '2024-04-28', '2024-05-22', 24, 'Closed Won'),
(25, 6, 'Lead', '2024-06-05', '2024-06-08', 3, 'Advanced'),
(26, 6, 'Discovery Call', '2024-06-08', '2024-06-12', 4, 'Advanced'),
(27, 6, 'Demo Booked', '2024-06-12', '2024-06-19', 7, 'Advanced'),
(28, 6, 'Proposal Sent', '2024-06-19', '2024-06-27', 8, 'Advanced'),
(29, 6, 'Negotiation', '2024-06-27', '2024-07-08', 11, 'Closed Won'),
(30, 7, 'Lead', '2024-07-02', '2024-07-08', 6, 'Advanced'),
(31, 7, 'Discovery Call', '2024-07-08', '2024-07-17', 9, 'Advanced'),
(32, 7, 'Demo Booked', '2024-07-17', '2024-08-01', 15, 'Advanced'),
(33, 7, 'Proposal Sent', '2024-08-01', '2024-08-19', 18, 'Dropped Off'),
(34, 8, 'Lead', '2024-08-04', '2024-08-09', 5, 'Advanced'),
(35, 8, 'Discovery Call', '2024-08-09', '2024-08-16', 7, 'Advanced'),
(36, 8, 'Demo Booked', '2024-08-16', '2024-08-28', 12, 'Advanced'),
(37, 8, 'Proposal Sent', '2024-08-28', '2024-09-12', 15, 'Advanced'),
(38, 8, 'Negotiation', '2024-09-12', '2024-10-02', 20, 'Closed Won'),
(39, 9, 'Lead', '2024-10-04', '2024-10-07', 3, 'Advanced'),
(40, 9, 'Discovery Call', '2024-10-07', '2024-10-12', 5, 'Advanced'),
(41, 9, 'Demo Booked', '2024-10-12', '2024-10-20', 8, 'Advanced'),
(42, 9, 'Proposal Sent', '2024-10-20', '2024-10-30', 10, 'Advanced'),
(43, 9, 'Negotiation', '2024-10-30', '2024-11-14', 15, 'Closed Won'),
(44, 10, 'Lead', '2024-10-15', '2024-10-20', 5, 'Advanced'),
(45, 10, 'Discovery Call', '2024-10-20', '2024-10-28', 8, 'Advanced'),
(46, 10, 'Demo Booked', '2024-10-28', '2024-11-10', 13, 'Advanced'),
(47, 10, 'Proposal Sent', '2024-11-10', '2024-11-26', 16, 'Advanced'),
(48, 10, 'Negotiation', '2024-11-26', '2024-12-20', 24, 'Dropped Off'),
(49, 11, 'Lead', '2024-12-19', '2024-12-23', 4, 'Advanced'),
(50, 11, 'Discovery Call', '2024-12-23', '2024-12-29', 6, 'Advanced'),
(51, 11, 'Demo Booked', '2024-12-29', '2025-01-09', 11, 'Advanced'),
(52, 11, 'Proposal Sent', '2025-01-09', '2025-01-23', 14, 'Advanced'),
(53, 11, 'Negotiation', '2025-01-23', '2025-02-11', 19, 'Closed Won'),
(54, 12, 'Lead', '2025-02-25', '2025-02-28', 3, 'Advanced'),
(55, 12, 'Discovery Call', '2025-02-28', '2025-03-04', 4, 'Advanced'),
(56, 12, 'Demo Booked', '2025-03-04', '2025-03-11', 7, 'Advanced'),
(57, 12, 'Proposal Sent', '2025-03-11', '2025-03-20', 9, 'Advanced'),
(58, 12, 'Negotiation', '2025-03-20', '2025-04-03', 14, 'Closed Won'),
(59, 13, 'Lead', '2025-04-07', '2025-04-13', 6, 'Advanced'),
(60, 13, 'Discovery Call', '2025-04-13', '2025-04-22', 9, 'Advanced'),
(61, 13, 'Demo Booked', '2025-04-22', '2025-05-06', 14, 'Advanced'),
(62, 13, 'Proposal Sent', '2025-05-06', '2025-05-24', 18, 'Advanced'),
(63, 13, 'Negotiation', '2025-05-24', '2025-06-18', 25, 'Dropped Off'),
(64, 14, 'Lead', '2023-12-25', '2023-12-27', 2, 'Advanced'),
(65, 14, 'Discovery Call', '2023-12-27', '2023-12-31', 4, 'Advanced'),
(66, 14, 'Demo Booked', '2023-12-31', '2024-01-06', 6, 'Advanced'),
(67, 14, 'Proposal Sent', '2024-01-06', '2024-01-14', 8, 'Advanced'),
(68, 14, 'Negotiation', '2024-01-14', '2024-01-25', 11, 'Closed Won'),
(69, 15, 'Lead', '2024-01-09', '2024-01-14', 5, 'Advanced'),
(70, 15, 'Discovery Call', '2024-01-14', '2024-01-21', 7, 'Advanced'),
(71, 15, 'Demo Booked', '2024-01-21', '2024-02-02', 12, 'Advanced'),
(72, 15, 'Proposal Sent', '2024-02-02', '2024-02-16', 14, 'Advanced'),
(73, 15, 'Negotiation', '2024-02-16', '2024-03-07', 20, 'Closed Won'),
(74, 16, 'Lead', '2024-03-04', '2024-03-10', 6, 'Advanced'),
(75, 16, 'Discovery Call', '2024-03-10', '2024-03-19', 9, 'Advanced'),
(76, 16, 'Demo Booked', '2024-03-19', '2024-04-03', 15, 'Advanced'),
(77, 16, 'Proposal Sent', '2024-04-03', '2024-04-22', 19, 'Dropped Off'),
(78, 17, 'Lead', '2024-04-16', '2024-04-20', 4, 'Advanced'),
(79, 17, 'Discovery Call', '2024-04-20', '2024-04-25', 5, 'Advanced'),
(80, 17, 'Demo Booked', '2024-04-25', '2024-05-04', 9, 'Advanced'),
(81, 17, 'Proposal Sent', '2024-05-04', '2024-05-15', 11, 'Advanced'),
(82, 17, 'Negotiation', '2024-05-15', '2024-05-30', 15, 'Closed Won'),
(83, 18, 'Lead', '2024-06-05', '2024-06-12', 7, 'Advanced'),
(84, 18, 'Discovery Call', '2024-06-12', '2024-06-23', 11, 'Advanced'),
(85, 18, 'Demo Booked', '2024-06-23', '2024-07-11', 18, 'Dropped Off'),
(86, 19, 'Lead', '2024-06-18', '2024-06-23', 5, 'Advanced'),
(87, 19, 'Discovery Call', '2024-06-23', '2024-07-01', 8, 'Advanced'),
(88, 19, 'Demo Booked', '2024-07-01', '2024-07-15', 14, 'Advanced'),
(89, 19, 'Proposal Sent', '2024-07-15', '2024-08-01', 17, 'Advanced'),
(90, 19, 'Negotiation', '2024-08-01', '2024-08-25', 24, 'Closed Won'),
(91, 20, 'Lead', '2024-07-27', '2024-07-31', 4, 'Advanced'),
(92, 20, 'Discovery Call', '2024-07-31', '2024-08-06', 6, 'Advanced'),
(93, 20, 'Demo Booked', '2024-08-06', '2024-08-17', 11, 'Advanced'),
(94, 20, 'Proposal Sent', '2024-08-17', '2024-08-30', 13, 'Advanced'),
(95, 20, 'Negotiation', '2024-08-30', '2024-09-18', 19, 'Dropped Off'),
(96, 21, 'Lead', '2024-09-20', '2024-09-23', 3, 'Advanced'),
(97, 21, 'Discovery Call', '2024-09-23', '2024-09-28', 5, 'Advanced'),
(98, 21, 'Demo Booked', '2024-09-28', '2024-10-06', 8, 'Advanced'),
(99, 21, 'Proposal Sent', '2024-10-06', '2024-10-16', 10, 'Advanced'),
(100, 21, 'Negotiation', '2024-10-16', '2024-10-29', 13, 'Closed Won'),
(101, 22, 'Lead', '2024-10-11', '2024-10-16', 5, 'Advanced'),
(102, 22, 'Discovery Call', '2024-10-16', '2024-10-23', 7, 'Advanced'),
(103, 22, 'Demo Booked', '2024-10-23', '2024-11-04', 12, 'Advanced'),
(104, 22, 'Proposal Sent', '2024-11-04', '2024-11-19', 15, 'Advanced'),
(105, 22, 'Negotiation', '2024-11-19', '2024-12-11', 22, 'Closed Won'),
(106, 23, 'Lead', '2024-12-09', '2024-12-12', 3, 'Advanced'),
(107, 23, 'Discovery Call', '2024-12-12', '2024-12-17', 5, 'Advanced'),
(108, 23, 'Demo Booked', '2024-12-17', '2024-12-25', 8, 'Advanced'),
(109, 23, 'Proposal Sent', '2024-12-25', '2025-01-04', 10, 'Advanced'),
(110, 23, 'Negotiation', '2025-01-04', '2025-01-20', 16, 'Dropped Off'),
(111, 24, 'Lead', '2025-01-08', '2025-01-13', 5, 'Advanced'),
(112, 24, 'Discovery Call', '2025-01-13', '2025-01-21', 8, 'Advanced'),
(113, 24, 'Demo Booked', '2025-01-21', '2025-02-03', 13, 'Advanced'),
(114, 24, 'Proposal Sent', '2025-02-03', '2025-02-19', 16, 'Advanced'),
(115, 24, 'Negotiation', '2025-02-19', '2025-03-14', 23, 'Closed Won'),
(116, 25, 'Lead', '2025-03-12', '2025-03-17', 5, 'Advanced'),
(117, 25, 'Discovery Call', '2025-03-17', '2025-03-24', 7, 'Advanced'),
(118, 25, 'Demo Booked', '2025-03-24', '2025-04-04', 11, 'Advanced'),
(119, 25, 'Proposal Sent', '2025-04-04', '2025-04-18', 14, 'Advanced'),
(120, 25, 'Negotiation', '2025-04-18', '2025-05-08', 20, 'Dropped Off'),
(121, 26, 'Lead', '2025-05-11', '2025-05-15', 4, 'Advanced'),
(122, 26, 'Discovery Call', '2025-05-15', '2025-05-21', 6, 'Advanced'),
(123, 26, 'Demo Booked', '2025-05-21', '2025-05-30', 9, 'Advanced'),
(124, 26, 'Proposal Sent', '2025-05-30', '2025-06-11', 12, 'Advanced'),
(125, 26, 'Negotiation', '2025-06-11', '2025-06-27', 16, 'Closed Won'),
(126, 27, 'Lead', '2024-01-04', '2024-01-07', 3, 'Advanced'),
(127, 27, 'Discovery Call', '2024-01-07', '2024-01-11', 4, 'Advanced'),
(128, 27, 'Demo Booked', '2024-01-11', '2024-01-18', 7, 'Advanced'),
(129, 27, 'Proposal Sent', '2024-01-18', '2024-01-27', 9, 'Advanced'),
(130, 27, 'Negotiation', '2024-01-27', '2024-02-08', 12, 'Closed Won'),
(131, 28, 'Lead', '2024-01-18', '2024-01-26', 8, 'Advanced'),
(132, 28, 'Discovery Call', '2024-01-26', '2024-02-06', 11, 'Advanced'),
(133, 28, 'Demo Booked', '2024-02-06', '2024-02-25', 19, 'Advanced'),
(134, 28, 'Proposal Sent', '2024-02-25', '2024-03-19', 23, 'Dropped Off'),
(135, 29, 'Lead', '2024-03-11', '2024-03-17', 6, 'Advanced'),
(136, 29, 'Discovery Call', '2024-03-17', '2024-03-26', 9, 'Advanced'),
(137, 29, 'Demo Booked', '2024-03-26', '2024-04-10', 15, 'Advanced'),
(138, 29, 'Proposal Sent', '2024-04-10', '2024-04-30', 20, 'Dropped Off'),
(139, 30, 'Lead', '2024-04-17', '2024-04-21', 4, 'Advanced'),
(140, 30, 'Discovery Call', '2024-04-21', '2024-04-28', 7, 'Advanced'),
(141, 30, 'Demo Booked', '2024-04-28', '2024-05-09', 11, 'Advanced'),
(142, 30, 'Proposal Sent', '2024-05-09', '2024-05-23', 14, 'Advanced'),
(143, 30, 'Negotiation', '2024-05-23', '2024-06-12', 20, 'Closed Won'),
(144, 31, 'Lead', '2024-06-10', '2024-06-14', 4, 'Advanced'),
(145, 31, 'Discovery Call', '2024-06-14', '2024-06-19', 5, 'Advanced'),
(146, 31, 'Demo Booked', '2024-06-19', '2024-06-28', 9, 'Advanced'),
(147, 31, 'Proposal Sent', '2024-06-28', '2024-07-09', 11, 'Advanced'),
(148, 31, 'Negotiation', '2024-07-09', '2024-07-24', 15, 'Dropped Off'),
(149, 32, 'Lead', '2024-06-17', '2024-06-26', 9, 'Advanced'),
(150, 32, 'Discovery Call', '2024-06-26', '2024-07-10', 14, 'Advanced'),
(151, 32, 'Demo Booked', '2024-07-10', '2024-08-02', 23, 'Advanced'),
(152, 32, 'Proposal Sent', '2024-08-02', '2024-08-30', 28, 'Dropped Off'),
(153, 33, 'Lead', '2024-09-16', '2024-09-18', 2, 'Advanced'),
(154, 33, 'Discovery Call', '2024-09-18', '2024-09-21', 3, 'Advanced'),
(155, 33, 'Demo Booked', '2024-09-21', '2024-09-27', 6, 'Advanced'),
(156, 33, 'Proposal Sent', '2024-09-27', '2024-10-04', 7, 'Advanced'),
(157, 33, 'Negotiation', '2024-10-04', '2024-10-15', 11, 'Closed Won'),
(158, 34, 'Lead', '2024-09-16', '2024-09-24', 8, 'Advanced'),
(159, 34, 'Discovery Call', '2024-09-24', '2024-10-06', 12, 'Advanced'),
(160, 34, 'Demo Booked', '2024-10-06', '2024-10-27', 21, 'Advanced'),
(161, 34, 'Proposal Sent', '2024-10-27', '2024-11-22', 26, 'Dropped Off'),
(162, 35, 'Lead', '2024-11-29', '2024-12-02', 3, 'Advanced'),
(163, 35, 'Discovery Call', '2024-12-02', '2024-12-07', 5, 'Advanced'),
(164, 35, 'Demo Booked', '2024-12-07', '2024-12-15', 8, 'Advanced'),
(165, 35, 'Proposal Sent', '2024-12-15', '2024-12-25', 10, 'Advanced'),
(166, 35, 'Negotiation', '2024-12-25', '2025-01-08', 14, 'Closed Won'),
(167, 36, 'Lead', '2024-12-29', '2025-01-05', 7, 'Advanced'),
(168, 36, 'Discovery Call', '2025-01-05', '2025-01-16', 11, 'Advanced'),
(169, 36, 'Demo Booked', '2025-01-16', '2025-02-03', 18, 'Advanced'),
(170, 36, 'Proposal Sent', '2025-02-03', '2025-02-25', 22, 'Dropped Off'),
(171, 37, 'Lead', '2025-02-20', '2025-02-24', 4, 'Advanced'),
(172, 37, 'Discovery Call', '2025-02-24', '2025-03-02', 6, 'Advanced'),
(173, 37, 'Demo Booked', '2025-03-02', '2025-03-12', 10, 'Advanced'),
(174, 37, 'Proposal Sent', '2025-03-12', '2025-03-24', 12, 'Advanced'),
(175, 37, 'Negotiation', '2025-03-24', '2025-04-09', 16, 'Closed Won'),
(176, 38, 'Lead', '2025-04-14', '2025-04-19', 5, 'Advanced'),
(177, 38, 'Discovery Call', '2025-04-19', '2025-04-26', 7, 'Advanced'),
(178, 38, 'Demo Booked', '2025-04-26', '2025-05-07', 11, 'Advanced'),
(179, 38, 'Proposal Sent', '2025-05-07', '2025-05-21', 14, 'Dropped Off'),
(180, 39, 'Lead', '2025-05-11', '2025-05-15', 4, 'Advanced'),
(181, 39, 'Discovery Call', '2025-05-15', '2025-05-21', 6, 'Advanced'),
(182, 39, 'Demo Booked', '2025-05-21', '2025-05-31', 10, 'Advanced'),
(183, 39, 'Proposal Sent', '2025-05-31', '2025-06-13', 13, 'Advanced'),
(184, 39, 'Negotiation', '2025-06-13', '2025-07-02', 19, 'Closed Won'),
(185, 40, 'Lead', '2024-01-21', '2024-01-23', 2, 'Advanced'),
(186, 40, 'Discovery Call', '2024-01-23', '2024-01-27', 4, 'Advanced'),
(187, 40, 'Demo Booked', '2024-01-27', '2024-02-02', 6, 'Advanced'),
(188, 40, 'Proposal Sent', '2024-02-02', '2024-02-10', 8, 'Advanced'),
(189, 40, 'Negotiation', '2024-02-10', '2024-02-20', 10, 'Closed Won'),
(190, 41, 'Lead', '2024-01-22', '2024-01-28', 6, 'Advanced'),
(191, 41, 'Discovery Call', '2024-01-28', '2024-02-05', 8, 'Advanced'),
(192, 41, 'Demo Booked', '2024-02-05', '2024-02-19', 14, 'Advanced'),
(193, 41, 'Proposal Sent', '2024-02-19', '2024-03-07', 17, 'Advanced'),
(194, 41, 'Negotiation', '2024-03-07', '2024-03-31', 24, 'Dropped Off'),
(195, 42, 'Lead', '2024-04-04', '2024-04-07', 3, 'Advanced'),
(196, 42, 'Discovery Call', '2024-04-07', '2024-04-11', 4, 'Advanced'),
(197, 42, 'Demo Booked', '2024-04-11', '2024-04-18', 7, 'Advanced'),
(198, 42, 'Proposal Sent', '2024-04-18', '2024-04-27', 9, 'Advanced'),
(199, 42, 'Negotiation', '2024-04-27', '2024-05-10', 13, 'Closed Won'),
(200, 43, 'Lead', '2024-04-24', '2024-04-28', 4, 'Advanced'),
(201, 43, 'Discovery Call', '2024-04-28', '2024-05-05', 7, 'Advanced'),
(202, 43, 'Demo Booked', '2024-05-05', '2024-05-16', 11, 'Advanced'),
(203, 43, 'Proposal Sent', '2024-05-16', '2024-05-30', 14, 'Advanced'),
(204, 43, 'Negotiation', '2024-05-30', '2024-06-18', 19, 'Dropped Off'),
(205, 44, 'Lead', '2024-07-01', '2024-07-03', 2, 'Advanced'),
(206, 44, 'Discovery Call', '2024-07-03', '2024-07-06', 3, 'Advanced'),
(207, 44, 'Demo Booked', '2024-07-06', '2024-07-12', 6, 'Advanced'),
(208, 44, 'Proposal Sent', '2024-07-12', '2024-07-19', 7, 'Advanced'),
(209, 44, 'Negotiation', '2024-07-19', '2024-07-29', 10, 'Closed Won'),
(210, 45, 'Lead', '2024-07-29', '2024-08-01', 3, 'Advanced'),
(211, 45, 'Discovery Call', '2024-08-01', '2024-08-06', 5, 'Advanced'),
(212, 45, 'Demo Booked', '2024-08-06', '2024-08-15', 9, 'Advanced'),
(213, 45, 'Proposal Sent', '2024-08-15', '2024-08-26', 11, 'Advanced'),
(214, 45, 'Negotiation', '2024-08-26', '2024-09-10', 15, 'Closed Won'),
(215, 46, 'Lead', '2024-08-06', '2024-08-15', 9, 'Advanced'),
(216, 46, 'Discovery Call', '2024-08-15', '2024-08-29', 14, 'Advanced'),
(217, 46, 'Demo Booked', '2024-08-29', '2024-09-22', 24, 'Advanced'),
(218, 46, 'Proposal Sent', '2024-09-22', '2024-10-22', 30, 'Dropped Off'),
(219, 47, 'Lead', '2024-10-27', '2024-10-30', 3, 'Advanced'),
(220, 47, 'Discovery Call', '2024-10-30', '2024-11-03', 4, 'Advanced'),
(221, 47, 'Demo Booked', '2024-11-03', '2024-11-10', 7, 'Advanced'),
(222, 47, 'Proposal Sent', '2024-11-10', '2024-11-18', 8, 'Advanced'),
(223, 47, 'Negotiation', '2024-11-18', '2024-11-30', 12, 'Closed Won'),
(224, 48, 'Lead', '2024-11-13', '2024-11-18', 5, 'Advanced'),
(225, 48, 'Discovery Call', '2024-11-18', '2024-11-25', 7, 'Advanced'),
(226, 48, 'Demo Booked', '2024-11-25', '2024-12-07', 12, 'Advanced'),
(227, 48, 'Proposal Sent', '2024-12-07', '2024-12-23', 16, 'Advanced'),
(228, 48, 'Negotiation', '2024-12-23', '2025-01-14', 22, 'Dropped Off'),
(229, 49, 'Lead', '2025-01-18', '2025-01-21', 3, 'Advanced'),
(230, 49, 'Discovery Call', '2025-01-21', '2025-01-26', 5, 'Advanced'),
(231, 49, 'Demo Booked', '2025-01-26', '2025-02-03', 8, 'Advanced'),
(232, 49, 'Proposal Sent', '2025-02-03', '2025-02-13', 10, 'Advanced'),
(233, 49, 'Negotiation', '2025-02-13', '2025-02-28', 15, 'Closed Won'),
(234, 50, 'Lead', '2025-02-20', '2025-02-26', 6, 'Advanced'),
(235, 50, 'Discovery Call', '2025-02-26', '2025-03-07', 9, 'Advanced'),
(236, 50, 'Demo Booked', '2025-03-07', '2025-03-22', 15, 'Advanced'),
(237, 50, 'Proposal Sent', '2025-03-22', '2025-04-11', 20, 'Dropped Off'),
(238, 51, 'Lead', '2025-04-15', '2025-04-18', 3, 'Advanced'),
(239, 51, 'Discovery Call', '2025-04-18', '2025-04-23', 5, 'Advanced'),
(240, 51, 'Demo Booked', '2025-04-23', '2025-05-01', 8, 'Advanced'),
(241, 51, 'Proposal Sent', '2025-05-01', '2025-05-11', 10, 'Advanced'),
(242, 51, 'Negotiation', '2025-05-11', '2025-05-23', 12, 'Closed Won'),
(243, 52, 'Lead', '2025-04-27', '2025-05-03', 6, 'Advanced'),
(244, 52, 'Discovery Call', '2025-05-03', '2025-05-12', 9, 'Advanced'),
(245, 52, 'Demo Booked', '2025-05-12', '2025-05-26', 14, 'Advanced'),
(246, 52, 'Proposal Sent', '2025-05-26', '2025-06-13', 18, 'Advanced'),
(247, 52, 'Negotiation', '2025-06-13', '2025-07-07', 24, 'Dropped Off'),
(248, 53, 'Lead', '2023-12-19', '2023-12-22', 3, 'Advanced'),
(249, 53, 'Discovery Call', '2023-12-22', '2023-12-27', 5, 'Advanced'),
(250, 53, 'Demo Booked', '2023-12-27', '2024-01-04', 8, 'Advanced'),
(251, 53, 'Proposal Sent', '2024-01-04', '2024-01-14', 10, 'Advanced'),
(252, 53, 'Negotiation', '2024-01-14', '2024-01-30', 16, 'Closed Won'),
(253, 54, 'Lead', '2024-01-26', '2024-02-01', 6, 'Advanced'),
(254, 54, 'Discovery Call', '2024-02-01', '2024-02-09', 8, 'Advanced'),
(255, 54, 'Demo Booked', '2024-02-09', '2024-02-23', 14, 'Advanced'),
(256, 54, 'Proposal Sent', '2024-02-23', '2024-03-12', 18, 'Dropped Off'),
(257, 55, 'Lead', '2024-02-21', '2024-02-26', 5, 'Advanced'),
(258, 55, 'Discovery Call', '2024-02-26', '2024-03-05', 8, 'Advanced'),
(259, 55, 'Demo Booked', '2024-03-05', '2024-03-18', 13, 'Advanced'),
(260, 55, 'Proposal Sent', '2024-03-18', '2024-04-03', 16, 'Advanced'),
(261, 55, 'Negotiation', '2024-04-03', '2024-04-24', 21, 'Closed Won'),
(262, 56, 'Lead', '2024-05-03', '2024-05-06', 3, 'Advanced'),
(263, 56, 'Discovery Call', '2024-05-06', '2024-05-10', 4, 'Advanced'),
(264, 56, 'Demo Booked', '2024-05-10', '2024-05-17', 7, 'Advanced'),
(265, 56, 'Proposal Sent', '2024-05-17', '2024-05-25', 8, 'Advanced'),
(266, 56, 'Negotiation', '2024-05-25', '2024-06-05', 11, 'Closed Won'),
(267, 57, 'Lead', '2024-05-20', '2024-05-25', 5, 'Advanced'),
(268, 57, 'Discovery Call', '2024-05-25', '2024-06-01', 7, 'Advanced'),
(269, 57, 'Demo Booked', '2024-06-01', '2024-06-12', 11, 'Advanced'),
(270, 57, 'Proposal Sent', '2024-06-12', '2024-06-26', 14, 'Advanced'),
(271, 57, 'Negotiation', '2024-06-26', '2024-07-16', 20, 'Dropped Off'),
(272, 58, 'Lead', '2024-07-27', '2024-07-29', 2, 'Advanced'),
(273, 58, 'Discovery Call', '2024-07-29', '2024-08-02', 4, 'Advanced'),
(274, 58, 'Demo Booked', '2024-08-02', '2024-08-08', 6, 'Advanced'),
(275, 58, 'Proposal Sent', '2024-08-08', '2024-08-16', 8, 'Advanced'),
(276, 58, 'Negotiation', '2024-08-16', '2024-08-27', 11, 'Closed Won'),
(277, 59, 'Lead', '2024-08-02', '2024-08-07', 5, 'Advanced'),
(278, 59, 'Discovery Call', '2024-08-07', '2024-08-15', 8, 'Advanced'),
(279, 59, 'Demo Booked', '2024-08-15', '2024-08-28', 13, 'Advanced'),
(280, 59, 'Proposal Sent', '2024-08-28', '2024-09-14', 17, 'Advanced'),
(281, 59, 'Negotiation', '2024-09-14', '2024-10-08', 24, 'Closed Won'),
(282, 60, 'Lead', '2024-09-29', '2024-10-05', 6, 'Advanced'),
(283, 60, 'Discovery Call', '2024-10-05', '2024-10-14', 9, 'Advanced'),
(284, 60, 'Demo Booked', '2024-10-14', '2024-10-30', 16, 'Advanced'),
(285, 60, 'Proposal Sent', '2024-10-30', '2024-11-19', 20, 'Dropped Off'),
(286, 61, 'Lead', '2024-12-08', '2024-12-12', 4, 'Advanced'),
(287, 61, 'Discovery Call', '2024-12-12', '2024-12-17', 5, 'Advanced'),
(288, 61, 'Demo Booked', '2024-12-17', '2024-12-26', 9, 'Advanced'),
(289, 61, 'Proposal Sent', '2024-12-26', '2025-01-06', 11, 'Advanced'),
(290, 61, 'Negotiation', '2025-01-06', '2025-01-22', 16, 'Closed Won'),
(291, 62, 'Lead', '2024-12-27', '2025-01-04', 8, 'Advanced'),
(292, 62, 'Discovery Call', '2025-01-04', '2025-01-17', 13, 'Advanced'),
(293, 62, 'Demo Booked', '2025-01-17', '2025-02-07', 21, 'Advanced'),
(294, 62, 'Proposal Sent', '2025-02-07', '2025-03-05', 26, 'Dropped Off'),
(295, 63, 'Lead', '2025-03-09', '2025-03-12', 3, 'Advanced'),
(296, 63, 'Discovery Call', '2025-03-12', '2025-03-17', 5, 'Advanced'),
(297, 63, 'Demo Booked', '2025-03-17', '2025-03-25', 8, 'Advanced'),
(298, 63, 'Proposal Sent', '2025-03-25', '2025-04-04', 10, 'Advanced'),
(299, 63, 'Negotiation', '2025-04-04', '2025-04-17', 13, 'Closed Won'),
(300, 64, 'Lead', '2025-04-07', '2025-04-11', 4, 'Advanced'),
(301, 64, 'Discovery Call', '2025-04-11', '2025-04-18', 7, 'Advanced'),
(302, 64, 'Demo Booked', '2025-04-18', '2025-04-29', 11, 'Advanced'),
(303, 64, 'Proposal Sent', '2025-04-29', '2025-05-13', 14, 'Advanced'),
(304, 64, 'Negotiation', '2025-05-13', '2025-06-01', 19, 'Closed Won'),
(305, 65, 'Lead', '2025-05-16', '2025-05-21', 5, 'Advanced'),
(306, 65, 'Discovery Call', '2025-05-21', '2025-05-28', 7, 'Advanced'),
(307, 65, 'Demo Booked', '2025-05-28', '2025-06-09', 12, 'Advanced'),
(308, 65, 'Proposal Sent', '2025-06-09', '2025-06-24', 15, 'Advanced'),
(309, 65, 'Negotiation', '2025-06-24', '2025-07-15', 21, 'Dropped Off');


SELECT COUNT(*) FROM novu.funnel_events;


-- Deals Entered Per Funnel Stage

SELECT stage_name,
       COUNT(*) AS deals_entered

FROM novu.funnel_Events
GROUP BY stage_name
ORDER BY CASE stage_name
    WHEN 'Lead'              THEN 1
    WHEN 'Discovery Call'    THEN 2
    WHEN 'Demo Booked'       THEN 3
    WHEN 'Proposal Sent'     THEN 4
    WHEN 'Negotiation'       THEN 5
END;


-- Deals Dropped Off Per Funnel Stage

SELECT stage_name,
       COUNT(*) AS deals_dropped

FROM novu.funnel_Events
WHERE outcome = 'Dropped Off'
GROUP BY stage_name
ORDER BY CASE stage_name
    WHEN 'Lead'              THEN 1
    WHEN 'Discovery Call'    THEN 2
    WHEN 'Demo Booked'       THEN 3
    WHEN 'Proposal Sent'     THEN 4
    WHEN 'Negotiation'       THEN 5
END;

-- Conversion rate between deal stages

SELECT stage_name,
       COUNT(*) AS deals_entered,
       COUNT(CASE WHEN outcome != 'Dropped Off' THEN 1 END) AS deals_advanced,
       ROUND(
            COUNT(CASE WHEN outcome != 'Dropped Off' THEN 1 END)* 100.0 / COUNT(*), 1
            ) AS conversion_rate_pct

FROM novu.funnel_events
GROUP BY stage_name
ORDER BY CASE stage_name
    WHEN 'Lead'              THEN 1
    WHEN 'Discovery Call'    THEN 2
    WHEN 'Demo Booked'       THEN 3
    WHEN 'Proposal Sent'     THEN 4
    WHEN 'Negotiation'       THEN 5
END;


-- Average days spent per stage

SELECT stage_name,
       ROUND(AVG(days_in_stage), 1) AS avg_days_in_stage

FROM novu.funnel_events
GROUP BY stage_name
ORDER BY CASE stage_name
    WHEN 'Lead'              THEN 1
    WHEN 'Discovery Call'    THEN 2
    WHEN 'Demo Booked'       THEN 3
    WHEN 'Proposal Sent'     THEN 4
    WHEN 'Negotiation'       THEN 5
END;


-- Conversion Rate by Rep

SELECT rep_name,
       stage_name,
       COUNT(*) AS deals_entered,
       ROUND(
            COUNT(CASE WHEN outcome != 'Dropped Off' THEN 1 END)* 100.0 / COUNT(*), 1
            ) AS conversion_rate_pct

FROM novu.funnel_events fe
JOIN novu.deals d ON fe.deal_id = d.deal_id
JOIN novu.reps r ON d.rep_id = r.rep_id
GROUP BY r.rep_name, fe.stage_name
ORDER BY CASE stage_name
    WHEN 'Lead'              THEN 1
    WHEN 'Discovery Call'    THEN 2
    WHEN 'Demo Booked'       THEN 3
    WHEN 'Proposal Sent'     THEN 4
    WHEN 'Negotiation'       THEN 5
END;


-- Stage Conversion Rate by Deal Source

SELECT stage_name,
       deal_source,
       COUNT(*) AS deals_entered,
       ROUND(
            COUNT(CASE WHEN outcome != 'Dropped Off' THEN 1 END) * 100.0 / COUNT(*), 1
            ) AS conversion_rate_deal_source

FROM novu.funnel_events fe
JOIN novu.deals d ON d.deal_id = fe.deal_id
GROUP BY fe.stage_name, d.deal_source
ORDER BY CASE stage_name
    WHEN 'Lead'              THEN 1
    WHEN 'Discovery Call'    THEN 2
    WHEN 'Demo Booked'       THEN 3
    WHEN 'Proposal Sent'     THEN 4
    WHEN 'Negotiation'       THEN 5
END;


-- Average Days in Stage by Rep

SELECT rep_name,
       stage_name,
       ROUND(AVG(days_in_stage), 1) AS avg_days_in_stage

FROM novu.funnel_events fe 
JOIN novu.deals d ON d.deal_id = fe.deal_id
JOIN novu.reps r ON d.rep_id = r.rep_id
GROUP BY r.rep_name, fe.stage_name
ORDER BY CASE stage_name
    WHEN 'Lead'              THEN 1
    WHEN 'Discovery Call'    THEN 2
    WHEN 'Demo Booked'       THEN 3
    WHEN 'Proposal Sent'     THEN 4
    WHEN 'Negotiation'       THEN 5
END;


-- Full Funnel Summary

SELECT stage_name,
       COUNT(*) AS deals_entered,
       COUNT(CASE WHEN outcome = 'Dropped Off' THEN 1 END) AS deals_dropped,
       ROUND(COUNT(CASE WHEN outcome != 'Dropped Off' THEN 1 END) * 100.0 / COUNT(*) , 1
            ) AS conversion_rate_pct

FROM novu.funnel_events
GROUP BY stage_name
ORDER BY CASE stage_name
    WHEN 'Lead'              THEN 1
    WHEN 'Discovery Call'    THEN 2
    WHEN 'Demo Booked'       THEN 3
    WHEN 'Proposal Sent'     THEN 4
    WHEN 'Negotiation'       THEN 5
END;

