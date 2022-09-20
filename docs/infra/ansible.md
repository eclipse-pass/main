# Ansible

## Installation

Ansible can be installed using PIP on any platform but some platforms (e.g., Ubuntu) have packages that make installation easier.

Checkout the [Ansible installation guide](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installation-guide) for instructions.

## Setup

Ansible requires a control node (which must have Ansible installed) and any number of remote clients which can be modified by Ansible. Each remote system must be ssh-accessible from the control node but has no other prerequisites.

### Managed nodes

Remote systems in Ansible are known as "managed nodes". The control node must be able to ssh to each managed node that it wants to modify. To do this, the `.ssh/authorized_keys` file on each managed node must have the public key for an ssh key available on the control node.

The list of nodes managed by Ansible can be managed multiple ways:

1. In the `/etc/ansible/hosts` file on the control node.
2. In an `~/inventory.yaml` file. The file can be named or located elsewhere but then the path must be provided in each inventory command.

### The Playbook

To execute tasks on a managed node, you'll need to create a "playbook". This is a yaml file containing a reference to the group of managed nodes that it applies to and the list of tasks to be performed.

### Running locally

To run Ansible playbooks against the control node, set the `hosts` property in the playbook to `all` and then when running the playbook, specify `localhost,` (the comma is intentional) as the inventory:

```bash
ansible-playbook playbook.yaml -i localhost
```
