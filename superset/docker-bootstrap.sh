#!/usr/bin/env bash

set -eo pipefail

# If Cypress run – overwrite the password for admin and export env variables
if [ "$CYPRESS_CONFIG" == "true" ]; then
    export SUPERSET_CONFIG=tests.integration_tests.superset_test_config
    export SUPERSET_TESTENV=true
    export SUPERSET__SQLALCHEMY_DATABASE_URI=postgresql+psycopg2://superset:superset@db:5432/superset
fi

pip install duckdb-engine

if [[ "${1}" == "worker" ]]; then
  echo "Starting Celery worker..."
  celery --app=superset.tasks.celery_app:app worker -O fair -l INFO
elif [[ "${1}" == "beat" ]]; then
  echo "Starting Celery beat..."
  celery --app=superset.tasks.celery_app:app beat --pidfile /tmp/celerybeat.pid -l INFO -s "${SUPERSET_HOME}"/celerybeat-schedule
elif [[ "${1}" == "app" ]]; then
  echo "Starting web app..."
  flask run -p 8088 --with-threads --reload --debugger --host=0.0.0.0
elif [[ "${1}" == "app-gunicorn" ]]; then
  echo "Starting web app..."
  /usr/bin/run-server.sh
fi