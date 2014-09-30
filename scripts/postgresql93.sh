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

  cat > /etc/default/locale <<EOF
LANG=en_US.UTF-8
LANGUAGE=
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=en_US.UTF-8
EOF

  locale-gen en_US.UTF-8
  dpkg-reconfigure locales
fi

export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list

apt-get install wget ca-certificates
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
apt-get update

# Install postgres
apt-get install -y postgresql-9.3 libpq-dev postgresql-contrib-9.3

# Create DB
if [ ! -d '/usr/local/pgsql/data' ]; then
  mkdir -p /usr/local/pgsql/data
  chown postgres:postgres /usr/local/pgsql/data
  su - postgres -l -c '/usr/lib/postgresql/9.3/bin/initdb -D /usr/local/pgsql/data'

  # Setup hstor
  su - postgres -l -c 'psql -d template1 -c "create extension hstore;"'

  # Create vagrant user
  su - postgres -l -c 'createuser vagrant -s'
fi
