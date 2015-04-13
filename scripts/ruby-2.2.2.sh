# Installs RVM & Ruby 2.2.2 on 12.04 LTS Ubuntu
# add to Vagrantfile:
#  config.vm.provision 'shell', path: 'ruby-2.2.2.sh', privileged: false, keep_color: true

if [[ -s "/home/vagrant/.rvm/scripts/rvm" ]] ; then
  echo 'RVM installed, skipping RVM install'
else
  \curl -sSL https://get.rvm.io | bash -s -- --version 1.25.0
fi

source '/home/vagrant/.rvm/scripts/rvm'

if rvm list strings | grep -lq ruby-2.2.2 ; then
  echo 'Ruby 2.2.2 installed. Skipping installed.'
else
  rvm autolibs packages
  rvm requirements
  rvm install 2.2.2
  rvm use 2.2.2 --default
  gem update bundler
fi

echo 'Setting Ruby 2.2.2 as default'
