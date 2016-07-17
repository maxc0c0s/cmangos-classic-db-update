#!/bin/bash

CONFIG_FILENAME="InstallFullDB.config"
CONFIG_FILE="$CONFIG_DIR/$CONFIG_FILENAME"

if [ -z $CMANGOS_VERSION ]
then
  echo 'You need to specify the $CMANGOS_VERSION environment variable, which is the cmangos/mangos-classic version...see https://github.com/cmangos/mangos-classic/releases'
  exit 1
fi
if [ ! -e $CONFIG_FILE ]; then
  echo "$CONFIG_FILE is missing, you can generate it by running: https://github.com/classicdb/database/blob/classic/InstallFullDB.sh"
  exit 1
fi

TEMP_DIR="/tmp"
DB_PACKAGE="$TEMP_DIR/db-package/cmangos-classic-database-${CMANGOS_VERSION}.tar.gz"
DB_DIR="$TEMP_DIR/database"

if [ ! -d $DB_DIR ]; then
  if [ ! -e $DB_PACKAGE ];then
    echo "$DB_PACKAGE missing...this file can be generated using https://github.com/maxc0c0s/cmangos-classic-deploy"
    exit 1
  fi
  echo "extracting $DB_PACKAGE"
  tar -xf $DB_PACKAGE -C $TEMP_DIR
fi

echo "Getting latest version of classic db ..."
git pull
echo "Getting latest version of classic db completed"

echo "Copying configs ..."
cp $CONFIG_FILE $BIN_DIR/$CONFIG_FILENAME
echo "Copying configs completed"

./InstallFullDB.sh

exec $@
