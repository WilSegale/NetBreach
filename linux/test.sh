#!/bin/bash

# Check for VMware Tools
if [ -e "/usr/sbin/vmware-toolbox-cmd" ] || [ -e "/usr/sbin/vmtoolsd" ]; then
    echo "Detected VMware virtual machine."
fi

# Check for VirtualBox Guest Additions
if [ -e "/opt/VirtualBoxGuestAdditions-*/init/vboxadd" ]; then
    echo "Detected VirtualBox virtual machine."
fi

# Check for Parallels Tools
if [ -d "/usr/lib/parallels-tools" ]; then
    echo "Detected Parallels virtual machine."
fi

# Check for QEMU/KVM
if [ -d "/var/run/libvirt" ]; then
    echo "Detected QEMU/KVM virtual machine."
fi

# Check for Microsoft Hyper-V
if [ -e "/sys/class/dmi/id/product_name" ] && grep -qi "Virtual" "/sys/class/dmi/id/product_name"; then
    echo "Detected Microsoft Hyper-V virtual machine."
fi

# Add more checks for other virtualization platforms as needed

# If none of the checks matched, assume it's a physical host
if [ -z "$(grep -E '^flags.*(vmx|svm)' /proc/cpuinfo)" ]; then
    echo "Running on a physical host."
fi

