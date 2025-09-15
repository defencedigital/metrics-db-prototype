-- insert_data.sql

-- Insert sample user data
-- This data is a simple representation of what would be parsed from a CSV file.
INSERT INTO users (first_name, last_name, email) VALUES
('John', 'Doe', 'john.doe@example.com'),
('Jane', 'Smith', 'jane.smith@example.com'),
('Peter', 'Jones', 'peter.jones@example.com'),
('Mary', 'Williams', 'mary.williams@example.com');

-- Insert sample product data
INSERT INTO products (name, price, stock) VALUES
('Laptop', 1200.50, 50),
('Keyboard', 75.00, 200),
('Mouse', 25.00, 350),
('Monitor', 300.75, 75);
