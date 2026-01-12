Installation VM (UbuntuServer iso) + Docker sur VM (en suivant la config fourni par le pdf)

sudo apt update && sudo apt install docker.io -y

sudo docker run --name webserver -d -p 80:80 nginx

curl localhost

sudo docker exec -it webserver bash

exit

sudo nano /etc/netplan/50-cloud-init.yaml

edit du fichier

sudo netplan apply

sudo reboot now