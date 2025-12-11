#!/usr/bin/env bash
set -euo pipefail

echo "[INFO]: Running bundle install..."
bundle install --jobs 4 --retry 3

echo "[INFO]: Waiting for database at $DB_HOST:$DB_PORT..."
until (echo >/dev/tcp/"$DB_HOST"/"$DB_PORT") >/dev/null 2>&1; do
  echo "[INFO]: Database not available yet, retrying in 1 second..."
  sleep 1
done
echo "[INFO]: Database is available."

echo "[INFO]: Waiting for Redis at $REDIS_HOST:$REDIS_PORT..."
until (echo >/dev/tcp/"$REDIS_HOST"/"$REDIS_PORT") >/dev/null 2>&1; do
  echo "[INFO]: Redis not available yet, retrying in 1 second..."
  sleep 1
done
echo "[INFO]: Redis is available."

echo "[INFO]: Preparing database (db:prepare)..."
bundle exec rails db:prepare

echo "[INFO]: Deleting old PID file if exists..."
rm -f /rails/tmp/pids/server.pid

echo "[INFO]: Starting Rails server..."
bundle exec rails s -p 3000 -b '0.0.0.0'
