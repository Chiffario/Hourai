#!/bin/sh

# Note: !/bin/sh must be at the top of the line,
# Alpine doesn't have bash so we need to use sh.
# Docker entrypoint script.
# Don't forget to give this file execution rights via `chmod +x entrypoint.sh`
# which I've added to the Dockerfile but you could do this manually instead.

# Wait until Postgres is ready before running the next step.
while ! pg_isready -U $POSTGRES_USERNAME -p $POSTGRES_PORT -d $POSTGRES_DB -h psql
do
  echo "$(date) - waiting for database to start."
  sleep 2
done

print_db_name()
{
  `PGPASSWORD=$POSTGRES_PASSWORD psql -h $POSTGRES_HOST
  -U $POSTGRES_USER -Atqc "\\list $POSTGRES_DB"`
}

# Create the database if it doesn't exist.
# -z flag returns true if string is null.
if [[ -z print_db_name ]]; then
  echo "Database $POSTGRES_DB does not exist. Creating..."
  mix ecto.create
  echo "Database $POSTGRES_DB created."
fi

# Runs migrations, will skip if migrations are up to date.
echo "Database $POSTGRES_DB exists, running migrations..."
mix ecto.migrate
echo "Migrations finished."

# Start the server.
exec mix phx.server
