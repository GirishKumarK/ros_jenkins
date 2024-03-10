#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/noetic/setup.bash"
source "/ros1_ws/devel/setup.bash"

# execute user cmd
exec "$@"