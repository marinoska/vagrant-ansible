## Vagrant-Ansible-PHP7.1

Vagrant provision with Ansible + Ant target to install Symfony3 with mongodb doctrine bundle support adapted to PHP7.1

Features include:
- Ubuntu 14.04
- Basic server configuration
- PHP 7.1 (CLI, PHP-FPM)
- MySQL
- MongoDB
- NGINX with basic configuration for a Synfony 2/3 project
- Ant
- Composer
- Git
- Sendmail
- Symfony3 install Ant project including MongoDB-bundle-to-PHP7 adaptor 

#### Requirements & Dependencies
- Tested with Ansible 2.2, there is no guarantee it will work on lower version
- Tested with Vagrant 1.9.1 + VirtualBox 5.1

#### Launch the machine
- Remove an entry of the following IP address from known_hosts: `ssh-keygen -R 192.168.33.10` otherwise it might cause a host UNREACHABLE error
- Download/clone this project next to your Symfony working project directory is - otherwise you'll have to change paths in ansible.cfg, play.yml and also in Vagrantfile 
- run in your project dir
```
>> cp -r ../vagrant-ansible/dist/* . && vagrant up
```
- Vagrantbox runs on 192.168.33.10
- Project's folder is syncronized with /var/www in Vagrantbox
- Your Ansible configuration is stored in `ansible` folder in your project
- to run ansible provision manually run `ansible-playbook ansible/play.yml` in your project dir or `vagrant provision`

#### Install Synfony3 with mongodb support
Ssh into Vagrantbox `vagrant ssh` and run in the Vagrantbox `ant -f build-symfony.xml composer-install-symfony`
- add `192.168.33.10 website.dev.local` line in your local /etc/hosts
- add `192.168.33.10 website.prod.local` line in your local /etc/hosts
- website.dev.local and website.prod.local refer to app_dev.php and app.php of your symfony project respectively
- `symfony` mysql scheme and `symfony` username are created (with empty password)

#### Try if everething works
- this should work from project's dir: `ansible -m ping -i ansible/hosts-dev all`
- run in browser http://website.dev.local and http://website.prod.local for dev and prod environment respectively  
- check if symfony database exists: `mysql -u root` then `show databases;` you should see `symfony` database in the list

#### Configuration
- to change a site name go in ansible/hosts-dev and replace `website` with whatever you want 
- nginx config is located in ansible/group_vars/webservers/nginx_symfony 
- MySQL config is in ansible/group_vars/dbservers/mysql
- IP-address of vagrantbox's webserver is in Vagrantfile and ansible/hosts-dev

#### To do list
- provide xdebug.ini config with
```
xdebug.remote_enable=1
xdebug.profiler_enable=1
xdebug.remote_port=9000
xdebug.remote_host=192.168.33.1
xdebug.remote_autostart=0  
```
- inside the box, comment out the bind_ip line from /etc/mongod.conf.
```
# Listen to local interface only. Comment out to listen on all interfaces.
# bind_ip = 127.0.0.1
```
Create sessions dir:  mkdir -p /var/sessions
&& chown www-data:vagrant /var/sessions
```

#### Just reminds me how it works
Ansible Variable Precendence
extra vars (-e in the command line) always win
then comes connection variables defined in inventory (ansible_user, etc)
then comes "most everything else" (command line switches, vars in play, included vars, role vars, etc)
then comes the rest of the variables defined in inventory
then comes facts discovered about a system
then "role defaults", which are the most "defaulty" and lose in priority to everything.
