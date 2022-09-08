#!/bin/bash

clear

resize > /dev/null 2>&1 # redirect output and error

HR=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)
HR2=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =)

#####################

echo "Running all install scripts:"
echo $HR

./setup_1_create_main.sh && \
./setup_2_create_worker1.sh && \
./setup_3_create_worker2.sh && \
./setup_4_join_workers.sh && \
./setup_5_pip_installs.sh