création du vdi et association au controleur SATA
sudo fdisk -l
sudo fdisk /dev/sdb (créer/nouvelle partition/numéro de partition/save et quitter)
ce qui me donne sdb1
sudo mkfs.ext4 /dev/sdb1
sudo mkdir /mnt/disk2
sudo mount /dev/sdb1 /mnt/disk2
df -h (vérif des disk et des mount)