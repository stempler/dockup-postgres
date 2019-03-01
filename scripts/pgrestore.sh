#!/bin/bash

source ./pgconfig.sh

POSTGRES_RESTORE_CMD="/usr/bin/pg_restore -U ${POSTGRES_USER} -h ${POSTGRES_HOST} -p ${POSTGRES_PORT} -d ${POSTGRES_DB} ${POSTGRES_RESTORE_EXTRA_OPTS} /dockup/pgdump/${POSTGRES_BACKUP_NAME}"

echo "Restoring Postgres database dump..."
eval "time $POSTGRES_RESTORE_CMD"
rc=$?
./pgclean.sh

if [ $rc -ne 0 ]; then
  echo "ERROR: Failed to restore Postgres dump"
  exit $rc
else
  echo "Successfully restored database dump"
fi
