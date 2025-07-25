#!/bin/bash
set -e

USER_ID=${HOST_UID:-1000}
GROUP_ID=${HOST_GID:-1000}
USERNAME=${HOST_USER:-hostuser}

# Check for existing user with same UID and delete it if necessary
EXISTING_USER=$(getent passwd "$USER_ID" | cut -d: -f1)
if [ -n "$EXISTING_USER" ]; then
    echo "Removing existing user with UID $USER_ID: $EXISTING_USER"
    userdel -r "$EXISTING_USER" || true
fi

# Create the group if it doesn't exist
if ! getent group "$GROUP_ID" >/dev/null; then
    groupadd -g "$GROUP_ID" "$USERNAME"
fi

# Create the user with matching UID/GID
useradd -m -u "$USER_ID" -g "$GROUP_ID" -s /bin/bash "$USERNAME"

export LANG=en_GB.UTF-8
export LANGUAGE=en_GB:en
export LC_ALL=en_GB.UTF-8

# Use 'exec su -' to launch the app as the correct user
exec su -m "$USERNAME" -c "/usr/bin/AnycubicSlicerNext"
#exec su -m "$USERNAME" -c /bin/bash



