## Vagrant-Ansible-PHP7.1

Vagrant provision with Ansible + Ant target to install Symfony3 with mongodb doctrine bundle support adapted to PHP7.1

Features include:
- Ubuntu 14.04
- Basic configuration
- PHP 7.1 (CLI, PHP-FPM)
- MySQL
- MongoDB
- NGINX with basic configuration for a Synfony 2/3 project
- Ant
- Composer
- Git
- Symfony3 Ant job with MongoDB-bundle-to-PHP7 adaptor 

cp -r ../vagrant-ansible/dist/* . && vagrant up && vagrant ssh
ant composer-install-symfony
#### Requirements & Dependencies
- Tested with Ansible 2.2, there is no guarantee it will work on lower version
- Tested with Vagrant 1.9.1 + VirtualBox 5.1

#### Launch the machine
- Remove an entry for this IP address from known_hosts: `ssh-keygen -R 192.168.33.10` otherwise it might cause a host UNREACHABLE error
- Download/clone this project somewhere on your local machine (I prefer to have it on the same level where my project is)
- Copy files from /dist into a Symfony3 project folder, remove ".dist" postfix from this file's names
- Change paths in ansible.cfg and play.yml to the actual ansible project path, also fix the path in Vagrantfile for this parameter - ansible.inventory_path
- Run `vagrant up` in the folder where Vagrant file is (the root of your project)
- Vagrantbox will run on 192.168.33.10 address
- Project's folder will be syncronized with /var/www in Vagrantbox
- Site root directory will be /var/www/web - app.php and app_dev.php index files are expected in root  

#### Try if everething works
- this should work from project's folder: `ansible -m ping -i hosts-dev all`
- ssh into vagrantbox: `vagrant ssh`
- add `192.168.33.10 vagrant.site` line in your local /etc/hosts
- run in browser http://website.dev.local and http://website.prod.local for dev and prod environment respectively  
- to run ansible provision manually `ansible-playbook play.yml`
- - check if symfony database exists: `mysql -u root` then `show databases;` you should see Symfony database in the list

#### Configuration
- to change a site name go [ansible-dir]into hosts-dev and replace `website` with whatever you want
- to change an hginx config go into [ansible-dir]/group_vars/webservers/nginx_symfony config before installation
- to change a MySQL initial parameters  for db/user creation  go into  [ansible-dir]/group_vars/dbservers/mysql config before installation
- to change an IP (and other parameters) go into Vagrantfile before installation

#### Just reminds me how it works
Ansible Variable Precendence
extra vars (-e in the command line) always win
then comes connection variables defined in inventory (ansible_user, etc)
then comes "most everything else" (command line switches, vars in play, included vars, role vars, etc)
then comes the rest of the variables defined in inventory
then comes facts discovered about a system
then "role defaults", which are the most "defaulty" and lose in priority to everything.
