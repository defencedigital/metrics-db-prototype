# Dockerfile

# Use the official PostgreSQL image as the base
FROM registry.redhat.io/ubi8/postgresql-15:latest

# Copy the SQL initialization scripts into the container's entrypoint directory.
# The official postgres image automatically runs any .sql scripts found in this directory
# when the container is first started.
COPY 01_create_tables.sql /docker-entrypoint-initdb.d/
COPY 02_insert_data.sql /docker-entrypoint-initdb.d/

# Expose the default PostgreSQL port
EXPOSE 5432

# The official image's CMD will run the database server
# The default entrypoint will execute this CMD.
# We do not override it, as OpenShift will handle permissions.
