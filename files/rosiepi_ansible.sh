#!/bin/bash

URL=https://github.com/sommersoft/RosiePi_Ansible.git
BECOME_USER=rosie-ansible

ansible-pull -o -U $URL --become-user=$BECOME_USER
