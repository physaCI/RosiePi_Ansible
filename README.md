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
On a RaspberryPi 3B+ (requires 64-bit; untested on RPi4):
- Create a bootable system, using Ubuntu Server 19.04 (Disco). Disco includes
  the necessary version of gcc-arm-none-eabi to build circuitpython, and removes
  the nigh-impossible step of compiling gcc-arm for aarch64/arm64. The image
  can be found at the following address; select the ``preinstalled-server-arm64+raspi3``
  version:
  http://cdimage.ubuntu.com/ubuntu/releases/disco/release/

- Create a user `rosie`, with passwordless sudo privileges. Run the following
  logged in as `rosie`.

- Install Ansible:
  - We need to add the PPA repository to get the latest Ansible, and
    then install Ansible itself. Instructions come from:
    https://docs.ansible.com/latest/installation_guide/intro_installation.html#id18

    Add the following to `/etc/apt/sources.list`:
    ```shell
    ## apt source for Ansible
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

- The last Ansible play issues a system reboot, scheduled for 2 minutes into
  the future. If you accomplish the next step prior to that, the system will
  be fully operational upon restarting.

- Create the `.env` file in `/home/rosie/rosie_app/RosiePiApp/` that contains
  the RosieApp secrets. Contact the RosieApp admin for the necessary info. See
  Step 4 in:
  https://developer.github.com/apps/quickstart-guides/setting-up-your-development-environment/#step-4-prepare-the-runtime-environment

  _Note: if this is not accomplished before the reboot, the RosiePiApp service
         that runs through ``systemd`` will need to be restarted. A simple way
         to accomplish this: reboot the system. Otherwise, read the ``systemd``
         manual for restarting a service._
