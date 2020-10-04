# Local WordPress LAMP Stack

Spin up a local WordPress instance using Vagrant.

## Required Software

1. Vagrant: https://www.vagrantup.com/
2. Virtual Box: https://www.virtualbox.org/

## Usage

Once Vagrant and VirtualBox have been installed, open a new terminal window in the cloned repository path and instantiate Vagrant:

```bash
vagrant up
```

Vagrant will first install a plugin called ```vagrant-hostsupdater``` if this is the first time running ```vagrant up```. After the plugin(s) has been installed Vagrant will ask you to run ```vagrant up``` again.

Vagrant will take a few minutes to spin up and install LAMP and WordPress.

Once spun up your local development instance can be viewed here: http://wp.local.

WordPress core files can be found in the ```src``` folder within cloned repository.

## Credentials

The below credentials can be amended via ```vagrant-bootstrap.sh``` if needed. This needs to be done before the initial spin up of this Vagrant box.

### WordPress Login

Username | Password
---------|---------
wpuser   | wordpress


### MySQL Schema

IP            | Schema    | Username  | Password
--------------|-----------|-----------|---------
192.168.33.11 | wordpress | wordpress | wordpress

