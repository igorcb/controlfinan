#!/bin/sh
set -e

rm -f /app/tmp/pids/server.pid

until pg_isready -h "$DB_HOST" -U "$DB_USER" >/dev/null 2>&1; do
  echo "Aguardando o PostgreSQL..."
  sleep 1
done

bundle exec rake db:create db:migrate

exec "$@"
