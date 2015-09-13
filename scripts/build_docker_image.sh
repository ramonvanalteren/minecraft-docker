#!/usr/bin/env bash

# Small script to automate the commands for building a docker container

USER=ramon
PROJECT="spigot"
VERSION="1.0"
GCP_PROJECT="minecraft-1065"


sudo docker build -t ${USER}/${PROJECT} .
sudo docker tag ${USER}/${PROJECT} gcr.io/${GCP_PROJECT}/${PROJECT}-${VERSION}
sudo gcloud docker push gcr.io/${GCP_PROJECT}/${PROJECT}-${VERSION}

echo "On target host, execute: sudo gcloud docker pull gcr.io/${GCP_PROJECT}/${PROJECT}-${VERSION}"
echo "Followed by: sudo docker run -p 25565:25565 -d gcr.io/${GCP_PROJECT}/${PROJECT}-${VERSION}"
