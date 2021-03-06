# Integration testing on a MongoDB database provisioned by Ansible using Test Kitchen (INSPEC).

Test kitchen spins up a VM and provisions the VM using the playbook in the root directory mongodb.yml.

### The test consist of:
- mongodb version > 3.2
- we have defined mongodb to have a bind_ip of '0.0.0.0' and port 27017
The port and bind_ip is defined in the template which is going to be sent to vm.
The variables are defined in defaults so that its easily interchangeable.
- the service of mongod is enabled and running

## SETUP HELP

NOTE:
the VM is configured with ubuntu 16.04 and uses a ubuntu/xenial vm box.

### TO download Test Kitchen, CHEFDK was installed. which included the tool INSPEC to run our integration test.

If you are a  mac/linux user, run this command to make sure you a running the default ruby version (ignore if windows)
````
echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile && source ~/.bash_profile
````

In order for your test to work with Ansible, you have to install the kitchen-ansible gem on your machine.
````
gem install kitchen-ansible
````

### tests/integration/default/sample.rb - contains our integration test created in ruby

test/integration/default is where you'll save your test files to.
chefignore is where you ignore chef related files.
kitchen.yml: This file describes your testing configuration, which is what you want to test and the target platforms.


#### Appended into kitchen.yml:

tells Test kitchen to provision the VM using a specific playbook.
defines location of integration test.

````
provisioner:
  name: ansible_playbook
  hosts: test-kitchen
  playbook: ./app.yml

verifier:
  name: inspec

platforms:
  - name: ubuntu-16.04
    verifier:
    inspec_tests:
      - test/integration/default
    driver:
    box: ubuntu/xenial64
````

To run the integration test using locally, we use the kitchen.yml defining vagrant as our driver. (Vagrant and Virtual Box needs to be installed)

the command to spin up the local VM and test.
````
kitchen test
````
the command destroy the VM:
````
kitchen destroy
````

To run the integration test on a AWS instance, we use the kitchen.cloud.yml with information on the AWS instance linked to my personal AWS account:

the command to spin up the AWS instance and test.
````
KITCHEN_YAML=kitchen.cloud.yml kitchen test
````
