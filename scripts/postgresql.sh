# Set up locals

if [ ! -f /etc/profile.d/lang.sh ] ; then
  touch /etc/profile.d/lang.sh
fi

if grep -lq  'en_US.UTF-8' /etc/profile.d/lang.sh ; then
  echo 'Locals set up'
else
  echo 'export LANGUAGE="en_US.UTF-8"' >> /etc/profile.d/lang.sh
  echo 'export LANG="en_US.UTF-8"' >> /etc/profile.d/lang.sh
  echo 'export LC_ALL="en_US.UTF-8"' >> /etc/profile.d/lang.sh

  locale-gen en_US.UTF-8
  dpkg-reconfigure locales
fi

export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

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
