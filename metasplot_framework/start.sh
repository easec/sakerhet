#!/bin/bash

mkdir $HOME/.msf4
mkdir $HOME/.msf4/database

docker network create --subnet=172.18.0.0/16 msf

docker run --ip 172.18.0.2 --network msf --rm --name postgres -v "${HOME}/.msf4/database:/var/lib/postgresql/data" -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres -e POSTGRES_DB=msf -d postgres:11-alpine

docker run --rm -it --network msf --name msf --ip 172.18.0.3 -e DATABASE_URL='postgres://postgres:postgres@172.18.0.2:5432/msf' -v "${HOME}/.msf4:/home/msf/.msf4" -p 8443-8500:8443-8500 metasploitframework/metasploit-framework
