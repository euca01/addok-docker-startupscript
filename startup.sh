#!/bin/bash

# Create directories for Addok data
mkdir -p /home/addok-data

# Download Addok data and Docker Compose file
wget https://adresse.data.gouv.fr/data/ban/adresses/latest/addok/addok-france-bundle.zip -O /home/addok-france-bundle.zip
wget https://raw.githubusercontent.com/BaseAdresseNationale/addok-docker/master/docker-compose.yml -O /home/docker-compose.yml

# Use a temporary Docker container to unzip the file into the target directory
docker run --rm -v /home/addok-data:/data -v /home:/source alpine sh -c "apk add unzip && unzip /source/addok-france-bundle.zip -d /data"

# Clean up the downloaded zip file
rm /home/addok-france-bundle.zip

# Navigate to the directory containing the Docker Compose file
cd /home

# Run Docker Compose
docker run --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /home:/home -w /home docker/compose:latest up -d

