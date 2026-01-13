-- database creation
Create database support_ticket_analysis;
use support_ticket_analysis;

-- table creation
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email VARCHAR(50)
);

CREATE TABLE agents (
    agent_id INT PRIMARY KEY,
    agent_name VARCHAR(50),
    team VARCHAR(30)
);

CREATE TABLE tickets (
    ticket_id INT PRIMARY KEY,
    customer_id INT,
    agent_id INT,
    category VARCHAR(30),
    priority VARCHAR(10),     -- Low / Medium / High
    status VARCHAR(10),       -- Open / Closed
    created_date DATE,
    closed_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (agent_id) REFERENCES agents(agent_id)
);

