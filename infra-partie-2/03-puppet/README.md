sudo apt update && sudo apt upgrade -y

sudo apt install puppet-agent

sudo nano /etc/puppet/puppet.conf

sudo systemctl restart puppetmaster

sudo systemctl enable puppetmaster

sudo systemctl start puppet

sudo systemctl enable puppet

sudo nano /etc/puppet/manifests/site.pp

sudo puppet agent --test

systemctl status nginx (Active: active (running))

sudo mkdir /etc/puppet/modules/nginx/manifests

sudo mkdir /etc/puppet/modules/nginx/files

sudo nano /etc/puppet/modules/nginx/manifests/init.pp

sudo puppet agent --test

systemctl status nginx
