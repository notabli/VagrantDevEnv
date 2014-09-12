# Installs Elixir from github cloned source.
# Requires erlang.sh
# add to Vagrantfile:
#  config.vm.provision 'shell', path: 'erlang.sh'
#  config.vm.provision 'shell', privileged: false, path: 'elixir.sh'

if [ -d /home/vagrant/elixir ] ; then
  echo 'Elixir already installed'
else
  sudo apt-get install make -y
  cd ~
  git clone https://github.com/elixir-lang/elixir.git
  cd elixir
  git checkout v0.15.0
  make clean
  make
fi

if grep -lq 'elixir/bin' /home/vagrant/.bashrc ; then
  echo 'Elixir already added to path'
else
  echo 'export PATH=/home/vagrant/elixir/bin:$PATH' >> /home/vagrant/.bashrc
fi
