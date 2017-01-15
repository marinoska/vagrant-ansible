In order to test:
  ansible-playbook test.yml

to check if ansible works 
	 ansible -m ping -i hosts-dev all
rm ~/.ssh/known_hosts
Tutorial:
  https://github.com/codereviewvideos/ansible 
manually check if ansible works, ping it: ansible -m ping -i hosts vagrant
where hosts - inventory file, ping - ansible module, vagrant - name for group of hosts from the inventory file

Ansible Variable Precendence
extra vars (-e in the command line) always win
then comes connection variables defined in inventory (ansible_ssh_user, etc)
then comes "most everything else" (command line switches, vars in play, included vars, role vars, etc)
then comes the rest of the variables defined in inventory
then comes facts discovered about a system
then "role defaults", which are the most "defaulty" and lose in priority to everything.

Before I go on, I will say the place you should put your variables is - in the majority - the defaults/main.yml file.

The reasoning for this is that we can override the contents of defaults/main.yml very easily, whereas variables in vars/main.yml are pretty hard to override.
If you're creating a new role, let's say a role for installing MySQL, the chances are that you don't want to hard code the database name (or names) that are created by your role. Our roles should be re-usable, and that means our variables should be easily interchangable.
Both the vars/main.yml and defaults/main.yml files work similarly, only the order in which they are given priority by Ansible differs.
Should I Use The vars Directory or the defaults Directory?
I use vars directory for system specific variables.


