#!/bin/bash

# Define the list of mount points to check
mount_points=(
    "/mnt/point1"
    "/mnt/point2"
    "/mnt/point3"
)

# Flag to check if there are any missing mounts
missing_mounts=false

# Check each mount point
for mount_point in "${mount_points[@]}"; do
    if ! mountpoint -q "$mount_point"; then
        echo "Mount point $mount_point is not available."
        missing_mounts=true
    fi
done

# Restart autofs service if there are missing mounts
if $missing_mounts; then
    echo "Some mount points are not available. Restarting autofs service..."
    sudo systemctl restart autofs
    if [ $? -eq 0 ]; then
        echo "autofs service restarted successfully."
    else
        echo "Failed to restart autofs service."
    fi
else
    echo "All mount points are available."
fi
