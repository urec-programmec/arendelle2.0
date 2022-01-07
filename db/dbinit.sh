#!/bin/bash

python3 dbinit.py
PGPASSWORD=admin pg_restore -U postgres -d arendelle2.0 -1 master.sql