-- ticket_analysis

-- Total Tickets Raised
SELECT COUNT(*) AS total_tickets
FROM tickets;

-- Tickets by Status
SELECT status, COUNT(*) AS ticket_count
FROM tickets
GROUP BY status;

-- Tickets by Category
SELECT category, COUNT(*) AS total_tickets
FROM tickets
GROUP BY category
ORDER BY total_tickets DESC;

-- Average Resolution Time (Days)
SELECT 
  ROUND(AVG(DATEDIFF(closed_date, created_date)), 2) AS avg_resolution_days
FROM tickets
WHERE status = 'Closed';

-- Open High-Priority Tickets
SELECT ticket_id, category, priority
FROM tickets
WHERE status = 'Open' AND priority = 'High';

-- Agent-Wise Ticket Handling
SELECT 
  a.agent_name,
  COUNT(t.ticket_id) AS total_tickets
FROM agents a
LEFT JOIN tickets t
ON a.agent_id = t.agent_id
GROUP BY a.agent_name;

-- Agent Performance (Avg Resolution Time)
SELECT 
  a.agent_name,
  ROUND(AVG(DATEDIFF(t.closed_date, t.created_date)), 2) AS avg_days
FROM agents a
JOIN tickets t
ON a.agent_id = t.agent_id
WHERE t.status = 'Closed'
GROUP BY a.agent_name;

-- Customers with Multiple Tickets
SELECT 
  c.customer_name,
  COUNT(t.ticket_id) AS ticket_count
FROM customers c
JOIN tickets t
ON c.customer_id = t.customer_id
GROUP BY c.customer_name
HAVING ticket_count > 1;

-- SLA Classification
SELECT 
  ticket_id,
  CASE
    WHEN DATEDIFF(closed_date, created_date) <= 2 THEN 'Within SLA'
    WHEN DATEDIFF(closed_date, created_date) <= 5 THEN 'Slight Delay'
    ELSE 'SLA Breached'
  END AS sla_status
FROM tickets
WHERE status = 'Closed';
