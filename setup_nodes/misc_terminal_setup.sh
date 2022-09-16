#!/bin/bash

clear

resize > /dev/null 2>&1 # redirect output and error

HR=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)
HR2=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =)

#####

# We cannot use underbars _ in the multipass instance name, we are limited to a dash -

# Define main node
node_main='main'
echo "node_main: $node_main"

echo $HR2

# Minimal prompt
#terminal_setting="export PS1=\'$ \'"

# Prompt with directory


# To do this manually:
# PS1='\W\$ '
# source ~/.bashrc



#terminal_setting="export PS1='\W\$ '"

#multipass exec $node_main -- bash -c "sudo echo $terminal_setting >> ~/.bashrc"
# multipass exec $node_main -- sudo echo "sudo cat ~/.bashrc"

echo $HR2