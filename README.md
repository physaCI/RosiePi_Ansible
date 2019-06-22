RosiePi_Ansible
================
RaspberryPi Configuration Management For Running RosiePi.

This set of Ansible playbooks will initally setup a RaspberryPi to run
the [RosiePi GitHub App](https://github.com/sommersoft/RosiePiApp.git) server and the [RosiePi test platform](https://github.com/sommersoft/RosiePi). It will also
establish a cron job to run this same set of playbooks daily, so that the
configuration stays up to date.

Usage
-----
On the RaspberryPi:
- Create a user `rosie`, with passwordless sudo privileges.

- Create the `.env` file in `/home/usr/rosie` that contains the RosieApp
  secrets. Contact the RosieApp admin for the necessary info. See Step 4 in:
  https://developer.github.com/apps/quickstart-guides/setting-up-your-development-environment/#step-4-prepare-the-runtime-environment

- Install Ansible:
  - The playbooks in this repo require Python 3, so installing with
    `pip3 install ansible` is recommended.
  - If the target RaspberryPi doesn't have Python 2 installed, use of
    `apt install ansible` is also an option.

- Run the Ansible playbooks. Ansible is primarily used as a "push based"
  configuration manager. However, it can be used as a "pull based" system.
  That is how we will use it:
  ```shell
  ansible-pull -U https://github.com/sommersoft/RosiePi_Ansible.git
  ```
