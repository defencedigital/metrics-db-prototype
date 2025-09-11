# Dockerfile

# Use the official PostgreSQL image as the base
FROM postgres:14-alpine

# Set environment variables from the .env file.
# We use build-time arguments to prevent sensitive info from being in the image history,
# then pass them to runtime envs.
ARG POSTGRESQL_USER
ARG POSTGQL_PASSWORD
ARG POSTGQL_DATABASE

ENV POSTGRES_USER=$POSTGRESQL_USER
ENV POSTGRES_PASSWORD=$POSTGQL_PASSWORD
ENV POSTGRES_DB=$POSTGQL_DATABASE

# Copy the SQL initialization scripts into the container's entrypoint directory.
# The official postgres image automatically runs any .sql scripts found in this directory
# when the container is first started.
COPY create_tables.sql /docker-entrypoint-initdb.d/
COPY insert_data.sql /docker-entrypoint-initdb.d/

# Expose the default PostgreSQL port
EXPOSE 5432

# The official image's CMD will run the database server
# The default entrypoint will execute this CMD.
# We do not override it, as OpenShift will handle permissions.
