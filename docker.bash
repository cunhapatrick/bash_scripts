#!/bin/bash

#Set name
NAME=$(basename $0)

#Set option choices
OPTS="h1234"
PUSAGE=""

#This is how to use the script
usage="
Hello, "$USER".  This script will allow you to start the following. 
You can run as many as you like starting with a '-'.  Example below.

Usage:  ${NAME} [OPTIONS]

Options are:
  -h  Show this message.
  -1. Download latest image and run mongodb container
  -2. Download latest image and run mariadb container
  -3. Download latest image and run postgres container
  -4. Download latest image and run redis container

Example:

${NAME} -134
"

#Run script
while getopts :${OPTS} i ; do
    case $i in
    1) 
      echo "Downloading mongodb image..."
      docker pull mongodb
      echo "Mounting mongodb docker container"
      docker run --name mongo-docker -p 57017:57017 -d mongo
      echo "Finish container process, the mongo-docker container is running!!!"
    2)
      echo "Downloading mariadb image..."
      docker pull mariadb
      echo "Mounting mariadb docker container"
      docker run --name mdb -e MYSQL_ROOT_PASSWORD=1234 -d mariadb
      echo "Finish container process, the maria-docker container is running!!!"
      
    3)
      echo "Downloading postgres image..."
      docker pull postgres
      echo "Creating local postgresql data directory..."
      mkdir -p $HOME/docker/volumes/postgres
      echo "Mounting postgresql docker container..."
      docker run --name pg-docker -e POSTGRES_PASSWORD=1234 -d -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data postgres
      echo "Finish container process, the postgresql-docker container is running!!!"
    4)
      echo "Downloading redis image..."
      docker pull redis
      echo "Mounting redis container..."
      sudo docker run --name redis-docker -d -p 6379:6379 -i -t redis 
      echo "Finish container process, the redis-docker container is running!!!"
    5)
      echo "Starting to mine ETN."
    h | \?) PUSAGE=1;;
    esac
done

#Show help based on selection
if [ ${PUSAGE} ]; then
    echo "${usage}"
    exit 0
fi

#Check for input if none show help.
if [[ $1 == "" ]]; then
    echo "${usage}"
    exit 0
fi