#!/bin/bash

# Set the VNC server IP address and port
VNC_SERVER_IP="192.168.1.99"
VNC_SERVER_PORT="5900"

# Set the timeout for the nc command (in seconds)
TIMEOUT=3

# Use nc to test if the VNC server is listening on the specified IP address and port
if nc -w $TIMEOUT -z $VNC_SERVER_IP $VNC_SERVER_PORT; then
  echo "VNC server is listening on $VNC_SERVER_IP:$VNC_SERVER_PORT"
else
  echo "VNC server is not listening on $VNC_SERVER_IP:$VNC_SERVER_PORT"
fi