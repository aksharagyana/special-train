#!/bin/bash

# Directory to mount new filesystems
MOUNT_DIR_BASE="/mnt/disk"

# Get a list of all disks excluding mounted and system disks (sda, loop devices, etc.)
DISKS=$(lsblk -dpno NAME | grep -E "/dev/sd|/dev/vd" | grep -vE "/dev/sda|/dev/loop|/dev/sr")

# Function to check if a disk has a filesystem
has_filesystem() {
    local disk=$1
    if lsblk -f $disk | grep -q -E "ext|xfs|btrfs|ntfs|vfat"; then
        return 0
    else
        return 1
    fi
}

# Function to format and mount a disk
format_and_mount() {
    local disk=$1
    local mount_dir="${MOUNT_DIR_BASE}$(basename $disk)"
    
    echo "Formatting disk $disk..."
    mkfs.ext4 $disk
    
    echo "Creating mount point $mount_dir..."
    mkdir -p $mount_dir
    
    echo "Mounting disk $disk to $mount_dir..."
    mount $disk $mount_dir
    
    echo "Disk $disk mounted to $mount_dir."
}

echo "Starting to process unmounted disks..."

for disk in $DISKS; do
    # Check if the disk is mounted
    if mount | grep -q $disk; then
        echo "Disk $disk is already mounted."
    else
        # Check if the disk has a filesystem
        if has_filesystem $disk; then
            echo "Disk $disk already has a filesystem. Skipping formatting."
        else
            format_and_mount $disk
        fi
    fi
done

echo "Finished processing disks."
