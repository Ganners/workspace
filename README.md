Workstation Configuration
=========================

This started out from the How to manage your workstation configuration with
Ansible[^1] guide. The objective is to have a reproducible Ubuntu 20.04
environment configuration which I can make continually consistent across
multiple workstations and will enable me to bootstrap new environments
quickly.

Installation instructions
-------------------------

There are some secrets included in this repository. In order to make this work
(and to make the cron work), it's expected that you'll store a file with this
password in plaintext in ~/.vaultpass. Make sure that exists before proceeding.

```bash
echo 'PASS' >> ~/.vault_pass
```

Next you'll want to make sure ansible and git are both installed:

```bash
sudo apt-get update
sudo apt-get install software-properties-common ansible git
```

```bash
sudo ansible-pull --vault-password-file ~/.vault_pass -d /tmp/ws-1 --track-subs -U https://github.com/Ganners/workspace.git
```

Modifying secrets
-----------------

```bash
ansible-vault edit --vault-password-file ~/.vault_pass vars/secrets.yml
```

Finishing off the setup
-----------------------

 - [ ] Install OS updates
 - [ ] Restart computer
 - [ ] Authenticate with DropBox and selective sync desired directories
 - [ ] Press `[Ctrl + a]` + `I` inside TMUX to install TPM plugins

Links
-----

 - (1) https://opensource.com/article/18/3/manage-workstation-ansible
