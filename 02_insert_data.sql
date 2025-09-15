-- Insert sample data
INSERT INTO developers (username, organization, join_date, display_name, email) 
VALUES ('jason-sims', 'simsinator-test-org', '2025-09-06 00:00:00+00', 'Jason Sims', 'jason_sims84@outlook.com')
ON CONFLICT (username) DO NOTHING;

INSERT INTO developers (username, organization, join_date, display_name, email) 
VALUES ('simsinator-test', 'simsinator-test-org', '2025-09-06 00:00:00+00', 'Jason Sim', 'jason.sims.84@gmail.com')
ON CONFLICT (username) DO NOTHING;

-- Grant permissions to the metrics user
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO developer_metrics_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO developer_metrics_user;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO developer_metrics_user;
