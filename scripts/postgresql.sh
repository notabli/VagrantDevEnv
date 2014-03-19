# Install postgres
apt-get install -y postgresql libpq-dev postgresql-contrib

# Create DB
if [ ! -d '/usr/local/pgsql/data' ]; then
  mkdir -p /usr/local/pgsql/data
  chown postgres:postgres /usr/local/pgsql/data
  su - postgres -l -c '/usr/lib/postgresql/9.1/bin/initdb -D /usr/local/pgsql/data'

  # Setup hstor
  su - postgres -l -c 'psql -d template1 -c "create extension hstore;"'
fi

# Create vagrant user
su - postgres -l -c 'createuser vagrant -s'
