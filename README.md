RosiePi_Ansible
================
RaspberryPi Configuration Management For Running RosiePi.

This set of Ansible playbooks will initally setup a RaspberryPi to run
the [RosiePi GitHub App](https://github.com/sommersoft/RosiePiApp.git) server and the [RosiePi test platform](https://github.com/sommersoft/RosiePi). It will also
establish a cron job to run this same set of playbooks daily, so that the
configuration stays up to date.

This collection of playbooks was designed with Ansible 2.8, and uses syntax/features
that may not be available in previous versions.

Usage
-----
On the RaspberryPi:
- Create a user `rosie`, with passwordless sudo privileges. Run the following
  logged in as `rosie`.

- Install Ansible:
  - At time of writing, Ansible requires the `software-properties-common`
    package. `dirmngr` is also needed for a later step, but isn't included in
    Raspbian Stretch.
    ```shell
    sudo apt install software-properties-common
    sudo apt install dirmngr
    ```
  - Now we need to add the PPA repository to get the latest Ansible, and
    then install Ansible itself. Instructions come from:
    https://docs.ansible.com/latest/installation_guide/intro_installation.html#id18

    Add the following to `/etc/apt/sources.list`:
    ```shell
    deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main
    ```

    Now we can install Ansible itself.
    ```shell
    sudo apt-key adv --keyserver kerserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
    sudo apt update
    sudo apt install ansible
    ```

- Lastly, run the Ansible playbooks. Ansible is primarily used as a "push based"
  configuration manager. However, it can be used as a "pull based" system.
  That is how we will use it:
  ```shell
  ansible-pull -U https://github.com/sommersoft/RosiePi_Ansible.git -e "ansible_python_interpreter=/usr/bin/python3"
  ```
  _Note: the quotation marks with the `-e` argument are required._

- Create the `.env` file in `/home/rosie/rosie_app/RosiePiApp/` that contains
  the RosieApp secrets. Contact the RosieApp admin for the necessary info. See
  Step 4 in:
  https://developer.github.com/apps/quickstart-guides/setting-up-your-development-environment/#step-4-prepare-the-runtime-environment
