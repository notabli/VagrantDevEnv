# Installs Erlang via erlang-solutions repo
# add to Vagrantfile:
#  config.vm.provision 'shell', path: 'erlang.sh'

if grep -lq 'erlang-solutions' /etc/apt/sources.list ; then
  echo 'Erlang source already added'
else
  cd /tmp
  wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
  dpkg -i erlang-solutions_1.0_all.deb
  apt-get update -y
  apt-get install erlang -y
fi
