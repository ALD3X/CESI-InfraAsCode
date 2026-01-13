sudo apt install -y ansible

ansible --version => ansible [core 2.16.3]

sudo nano /etc/ansible/hosts

ansible all -m ping -u alex -k

192.168.1.16 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}

nano install_nginx.yaml

ansible-playbook install_nginx.yaml -k

ansible all -m ping -i /etc/ansible/hosts -k

192.168.1.16 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}

curl http://192.168.1.16
