apt-get update -y

# Common Packages
# memcached and redis will be running on their standard ports.
apt-get install -y curl redis-server memcached libcurl3 libcurl3-gnutls libcurl4-openssl-dev
