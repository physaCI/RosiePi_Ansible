# RosiePi_Ansible

## RaspberryPi Configuration Management For Running RosiePi.

This set of Ansible playbooks will initally setup a RaspberryPi to run the [RosiePi test platform](https://github.com/physaCI/RosiePi), [RosiePi Node Server](https://github.com/physaCI/RosiePi_Node_Server), and the [physaCI subscriber](https://github.com/physaCI/physaCI_subscriber) utility.

It will also establish a cron job to run this same set of playbooks regularly, so that the configuration stays up to date.

This collection of playbooks was designed with Ansible 2.8+, and uses syntax/features that may not be available in previous versions.

## Usage
----
This configuration has been designed within the following system. It may work under different system constructs, but it is not guaranteed.
- Raspberry Pi 3B+ or newer

- 64-bit OS. Ubuntu Server 19.10 (Eoan) and newer has been used. Ubuntu Raspberry Pi images can be found at the following address; select the `preinstalled-server-arm64+*` version: http://cdimage.ubuntu.com/ubuntu/release

On a Raspberry Pi:
- Create a bootable 64-bit system.

- Create a user with sudo privileges. Run the following steps logged in as that user.

- Since your Raspberry Pi will be running a public-facing web server, it is highly advised to setup the following hardening settings. The Ansible playbooks that will be initially run here, and as a scheduled `cron` job, will not configure these.

  - Filesystem Access Control Lists (ACL): https://help.ubuntu.com/community/FilePermissionsACLs
  - Firewall:
  - fail2ban:
  - Restrict SSH login:

- Install Ansible:
  - We will install Ansible for CPython 3. If you have not already done so, install pip, and then reboot:

    ```shell
    sudo apt-get install python3-pip
    ```

  - Now install the Ansible package:

    ```shell
    pip3 install ansible
    ```

  - Logout and log back in to make the installed package available.

- Run The Ansible Playbooks:
  - Ansible is primarily used as a "push based" configuration manager. However, it can be used as a "pull based" system. That is how we will use it:

    ```shell
    ansible-pull -U https://github.com/physaCI/RosiePi_Ansible.git
    ```

    _Notes:
      - If user does not have `sNOPASSWD` sudo privileges, use the `-K/--ask-become-pass` option. You will need to attend to the installation process, as it will ask for a password several times.
      - To enable more verbose output, add `-v` to the command. Multiple `v`'s increase verbosity (e.g. `-vvv`)._

  - The last Ansible play issues a system reboot, scheduled for 2 minutes into the future. If you accomplish the next step prior to that, the system will be fully operational upon restarting. The reboot can be canceled if desired via `shutdown -c`.

- Update The Configuration:
  - There is a shared configuration for communicating with the physaCI servers and RosiePi test runner. There are values that will need to be supplied before the system as a whole will operate. The configuration file is in the INI-style format (`[section] key=value`).

  - Open `/etc/opt/physaci_sub/conf.ini` with a text editor (`nano`, `vi`, etc.)

  - Update the following fields: ([section] key: value)
    - `[physaci]` `api_access_key`: Enter the access key supplied by the physaCI administrator.
    - `[rosie_pi]` `boards`: Enter a comma separated list of CircuitPython boards that are attached to the RosiePi node to be tested.
