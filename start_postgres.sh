#!/bin/bash

#Initialize data for pg engine
/usr/pgsql-9.5/bin/postgresql95-setup initdb

#Access from all over --- NEVER DO THIS SHIT IN POST DEV ENVs !!!!!!!!!!!!!!!!!!! <--- READ THIS
mv /postgresql.conf /var/lib/pgsql/9.5/data/postgresql.conf
mv /pg_hba.conf /var/lib/pgsql/9.5/data/pg_hba.conf

# Update data folder perms
chown -R postgres.postgres /var/lib/pgsql

# Start postgres daemon
exec su postgres -c "/usr/pgsql-9.5/bin/postgres -D /var/lib/pgsql/9.5/data"

# Update default postgres user password
exec su postgres -c "psql -c \"alter user postgres password 'password'\";"
