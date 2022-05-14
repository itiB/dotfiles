#!/bin/bash
set -e

echo "Use this script in sudo"
sudo -v

# echo "install Ansible..."
# sudo apt install --yes software-properties-common
# sudo apt-add-repository --yes --update ppa:ansible/ansible
# sudo apt install --yes ansible

# if [ -f "$HOME/.bashrc" ] && [ ! -h "$HOME/.bashrc" ]; then
#     echo "Backup: .bashrc"
#     mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
# fi

echo "Run Playbook"
# ansible-playbook ./playbooks/init.yml --ask-become-pass --syntax-check
# ansible-playbook ./playbooks/init.yml --ask-become-pass --check
ansible-playbook ./playbooks/init.yml --ask-become-pass