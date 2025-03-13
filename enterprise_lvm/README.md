NOTE: handlers are disable until I figure out how to install collections on AAP

# Enterprise LVM Storage Management Role

This Ansible role provides comprehensive management of LVM (Logical Volume Manager) storage, including partitioning, volume group creation, logical volume creation, filesystem configuration, and mounting. It ensures that storage devices are properly configured and mounted with SELinux context relabeling.

## Requirements

- Ansible 2.9+
- Community General Collection
- RedHat RHEL System Roles Collection

## Role Variables

The following variables can be overridden in `group_vars/all.yml` or provided from Ansible Automation Platform (AAP):

virtual_group_name: ""  # Name of the volume group
logical_volume_name: ""  # Name of the logical volume
mount_point: ""  # Mount point for the logical volume
my_volume: ""  # Physical volume device
partition_size: "100%"  # Size of the partition
fs_type: "xfs"  # Filesystem type
fs_options: "defaults,noatime,nodiratime"  # Filesystem mount options
lvm_pesize: "16M"  # Physical extent size for the volume group
selinux_type: "default_t"  # SELinux type for the mount point
Dependencies
None.

Example Playbook
```yaml
- hosts: all
  become: true
  roles:
    - role: enterprise_lvm
      vars:
        virtual_group_name: "vg_data"
        logical_volume_name: "lv_data"
        mount_point: "/mnt/data"
        my_volume: "/dev/sda"
        partition_size: "100%"
        fs_type: "xfs"
        fs_options: "defaults,noatime,nodiratime"
        lvm_pesize: "16M"
        selinux_type: "default_t"
License
MIT

Author Information
This role was created by Emile Krantz
