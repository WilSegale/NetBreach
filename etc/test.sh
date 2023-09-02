#!/bin/bash

# Check if the camera is accessible

camera_info=$(system_profiler SPCameraDataType 2>/dev/null)

if [ $? -eq 0 ]; then
    echo "Camera is accessible and not blocked."
    echo "Camera Info:"
    echo "$camera_info"
else
    echo "Camera is inaccessible or blocked by another process."
fi

