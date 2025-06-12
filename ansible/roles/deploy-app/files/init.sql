-- Create readonly user
CREATE USER readonly WITH PASSWORD 'readonlypass';

-- Grant access to sre database
GRANT CONNECT ON DATABASE sre TO readonly;
GRANT USAGE ON SCHEMA public TO readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT ON TABLES TO readonly;
