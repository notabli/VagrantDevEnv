apt-get install -y openjdk-7-jre-headless
if [ ! -f ~/elasticsearch-1.4.0.deb ]; then
  cd ~/
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.0.deb
  dpkg -i elasticsearch-1.4.0.deb
  service elasticsearch start
  update-rc.d elasticsearch defaults 95 10
fi
