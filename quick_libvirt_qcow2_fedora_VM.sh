## Use this script to whip up a quick local Test VM with Openstack Fedora Image (.qcow2)
## This VM can be used to test new software/configurations before using them in prod.
## It can easily be obliterated afterwards, or altered to better suit the host env.
#
## Inspiriation for Script from the following Enable Sysadmin post:
## https://www.redhat.com/sysadmin/build-lab-quickly
#
## This needs to be run as admin (sudo required)

# Install the pre-requisite software
TO_INSTALL="qemu-kvm \
virt-manager \
virt-viewer \
libguestfs-tools \
virt-install \
genisoimage"

dnf upgrade -y
sudo dnf install -y $TO_INSTALL 

# Or if OS=debian:
# sudo apt-get update
# sudo apt-get upgrade -y
# sudo apt-get install -y $TO_INSTALL 

# Download the Fedora .qcow2 image
curl -v https://download.fedoraproject.org/pub/fedora/linux/releases/34/Cloud/x86_64/images/Fedora-Cloud-Base-34-1.2.x86_64.qcow2 -o /var/lib/libvirt/images/Fedora-Cloud-Base-34-1.2.x86_64.qcow2

# Prepare test VM
sudo virt-customize \
-a /var/lib/libvirt/images/Fedora-Cloud-Base-34-1.2.x86_64.qcow2 \
--hostname vm01.test.lab \
--root-password password:<passwordhere> \
--ssh-inject 'root:file:labkey.pub' \
--uninstall cloud-init \ # Speed up VM boot time by un-coupling VM from OpenStack (since it is local)
--selinux-relabel # Important if host is Fedora/RHEL/CentOS

# Install test VM
sudo virt-install \
--name vm01 \
--memory 1024 \
--vcpus 1 \
--disk /var/lib/libvirt/images/Fedora-Cloud-Base-34-1.2.x86_64.qcow2 \
--import \
--os-type linux --os-variant generic \
--noautoconsole

# Verify the existance of your new VM
virsh list --all | grep vm01

# You can now access the VM with:
# sudo virsh domifaddr vmlab01
