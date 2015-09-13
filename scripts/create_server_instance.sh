#!/usr/bin/env bash 

# Create an instance in the zone specified.
# Create a persistent disk for saving world-data
# Format and mount that disk on the server

source vars.sh

gcloud compute disks create ${HOSTNAME}-world-disk1 --zone ${ZONE}

gcloud compute addresses create ${HOSTNAME}-ext-ip --region ${REGION}

gcloud compute instances create ${HOSTNAME} \
    --image container-vm \
    --zone ${ZONE} \
    --machine-type ${MACHINE_TYPE} \
    --address ${HOSTNAME}-ext-ip \
    --disk name=${HOSTNAME}-world-disk1 \
    --scopes storage-rw,compute-rw

# gcloud compute instances attach-disk ${HOSTNAME} \
#    --disk ${HOSTNAME}-world-disk1 \
#    --device-name ${HOSTNAME}-world-disk1 \
#    --zone ${ZONE}

gcloud compute ssh ${HOSTNAME} --zone ${ZONE} "echo \"mounting disk ${HOSTNAME}-world-disk1\""
