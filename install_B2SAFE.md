# Installation of B2SAFE 2
This document describes how to install B2SAFE 2 with iRODS4.1 on a Ubunutu 14.04 system.

## Environment
Ubuntu 14.04 server, iRODS 4.1 with postgresql 9.3

##Prerequisites
Also consult https://github.com/EUDAT-B2SAFE/B2SAFE-core/blob/master/install.txt
Install git:
```sh
sudo apt-get install git
```

### 1. Clone code and create packages
- Clone the github repository of B2SAFE and create the debian package
```sh
git clone https://github.com/EUDAT-B2SAFE/B2SAFE-core
cd /var/lib/irods/B2SAFE-core/packaging
./create_deb_package.sh
```

- Install the created package as *root*

dpkg -i /home/alice/debbuild/irods-eudat-b2safe_3.1-0.deb


### 2. Set firewall
```sh
sudo apt-get install iptables-persistent
```
