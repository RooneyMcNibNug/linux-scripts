# Learning more details about nvme so I created this one-liner for a secure wipe of and nvme drive 
# "nvme-cli" package is required for this to run
# see https://man.archlinux.org/man/nvme-format.1 or nvme spec: https://nvmexpress.org/developers/nvme-specification/

for i in `nvme list | awk '/nvme/ {print $1}'`; do echo $i; nvme format $i -s 2; sleep 2; done
