-- Developer Metrics Database Schema
-- Single table to store developer information as source of truth to support metrics

-- Enable UUID extension for better IDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Developers table - source of truth for all developer Github username and join date
CREATE TABLE developers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    
    -- GitHub information
    username VARCHAR(255) NOT NULL UNIQUE,
    github_id BIGINT UNIQUE,
    
    -- Display information
    display_name VARCHAR(255),
    email VARCHAR(320),
    
    -- Organization and timing
    organization VARCHAR(255) NOT NULL,
    join_date TIMESTAMP WITH TIME ZONE NOT NULL,
    
    -- Status
    is_active BOOLEAN DEFAULT true,
    
    -- Metadata
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for performance
CREATE INDEX idx_developers_organization ON developers(organization);
CREATE INDEX idx_developers_username ON developers(username);
CREATE INDEX idx_developers_join_date ON developers(join_date);
CREATE INDEX idx_developers_active ON developers(is_active) WHERE is_active = true;

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply updated_at trigger
CREATE TRIGGER update_developers_updated_at 
    BEFORE UPDATE ON developers 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
