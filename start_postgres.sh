#!/bin/bash

# Start postgres daemon
exec su postgres -c "/usr/pgsql-9.5/bin/postgres -D /var/lib/pgsql/9.5/data"

# Update default postgres user password
exec su postgres -c "psql -c \"alter user postgres password 'password'\";"
