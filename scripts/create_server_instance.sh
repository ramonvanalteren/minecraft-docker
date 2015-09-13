#!/usr/bin/ bash 

# Create an instance in the zone specified.
# Create a persistent disk for saving world-data
# Format and mount that disk on the server

source vars.sh

gcloud compute disks create ${DISK_NAME} --zone ${ZONE}

gcloud compute addresses create ${HOSTNAME}-ext-ip --region ${REGION}

gcloud compute instances create ${HOSTNAME} \
    --image container-vm \
    --zone ${ZONE} \
    --machine-type ${MACHINE_TYPE} \
    --address ${HOSTNAME}-ext-ip \
    --disk name=${DISK_NAME} \
    --scopes storage-rw,compute-rw

# gcloud compute instances attach-disk ${HOSTNAME} \
#    --disk ${HOSTNAME}-world-disk1 \
#    --device-name ${HOSTNAME}-world-disk1 \
#    --zone ${ZONE}

gcloud compute ssh ${HOSTNAME} --zone ${ZONE} "echo \"mounting disk ${HOSTNAME}-world-disk1\""
gcloud compute ssh ${HOSTNAME} --zone ${ZONE} "sudo mkdir -p ${MOUNT_POINT}"
gcloud compuet ssh ${HOSTNAME} --zone ${ZONE} "sudo /usr/share/google/safe_format_and_mount -m \"mkfs.ext4 -F\" \
    /dev/disk/by-id/google-${DISK_NAME} ${MOUNT_POINT}
