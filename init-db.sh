#!/bin/bash
# init-db.sh

# This script is executed by the s2i builder to initialize the PostgreSQL database.
# It waits for the PostgreSQL service to be ready and then runs the SQL scripts.

echo "Waiting for PostgreSQL service to become available..."

# We need to ensure the database is fully ready to accept connections before running scripts.
# The `oc new-app` template creates the service, but the database might not be ready immediately.
# We'll use a loop with `psql` to check for readiness.

# `PGPASSWORD` is provided by the OpenShift template
export PGPASSWORD=${POSTGRESQL_PASSWORD}

until psql -h localhost -U ${POSTGRESQL_USER} -d ${POSTGRESQL_DATABASE} -c '\q'; do
  >&2 echo "PostgreSQL is unavailable - sleeping"
  sleep 1
done

>&2 echo "PostgreSQL is up and running on localhost!"

echo "Running SQL scripts to initialize the database."

# Execute the SQL scripts in order
psql -h localhost -U ${POSTGRESQL_USER} -d ${POSTGRESQL_DATABASE} -f /opt/app-root/src/create_tables.sql
psql -h localhost -U ${POSTGRESQL_USER} -d ${POSTGRESQL_DATABASE} -f /opt/app-root/src/insert_data.sql

echo "Database initialization complete."
