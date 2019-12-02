#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "$DIR"
rm iis.db
echo ".read Database/database.sql" | sqlite3 iis.db
echo ".read Database/fill_data.sql" | sqlite3 iis.db

