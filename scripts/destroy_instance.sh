#!/usr/bin/env bash

# Small script to tear down an instance created by the create_instance script
# Source common vars first.
# Unmount persistent disk
# detach persistent disk
# Destroy instance

source vars.sh

gcloud compute ssh ${HOSTNAME} "sudo umount ${MOUNT_POINT}"

gcloud compute instances detach-disk ${HOSTNAME} --disk ${HOSTNAME}-world-disk1 --zone ${ZONE}
gcloud compute instances delete ${HOSTNAME}
gcloud compuet addresses delete ${HOSTNAME}-ext-ip --zone ${ZONE}
