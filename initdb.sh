#!/bin/bash

# Script to revert the database to its default state.

rm iis.db
sqlite3 iis.db < database/scheme.sql
sqlite3 iis.db < database/fill_data.sql

