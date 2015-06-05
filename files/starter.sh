#!/bin/bash
# Script tto start the test

# Ensure the /source tree and /var/run/docker socket are present
if [ ! -d /source ]; then
    echo "ERROR: Missing source tree at /source"
    exit 1
fi

if [ ! -S /var/run/docker.sock ]; then
    echo "ERROR: Docker socket not present at /var/run/docker.sock"
    exit 1
fi

# The docker group doesn't have a fixed GID by default.
# Ensure that the group is present and that specrunner is a member
# The grep is a sanity
dockergid=$(ls -n /var/run/docker.sock | awk '{print $4}' | grep '^[0-9]\+$')
if [ -z "$dockergid" ]; then
    echo "ERROR: Unable to determin Docker group GID"
    exit 1
fi

groupadd -g $dockergid docker
usermod -a -G docker specrunner

# Run the test as user specrunner
cd /source
su -c 'rake2.1 -f /testfiles/spec_rakefile spec' - specrunner
exit $?
