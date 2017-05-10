{% if "sysresccd" == grains["nodename"] %}

{% set mntPt = "/mnt/funtoo" %}
{% set mntFstab = mntPt ~ "/etc/fstab" %}

include:
  - .mountingFilesystems

{{sls}} - Remove all /dev/sda*'s from {{mntFstab}}:
  file.line:
    - name: {{mntFstab}}
    - match: /dev/sda
    - content:
    - mode: delete
    - require:
      - installFuntoo.mountingFilesystems - Mount btrfs /dev/sda as /mnt/funtoo

{{sls}} - Remove swap from {{mntFstab}}:
  file.line:
    - name: {{mntFstab}}
    - match: swap
    - content:
    - mode: delete
    - require:
      - installFuntoo.mountingFilesystems - Mount btrfs /dev/sda as /mnt/funtoo

{{sls}} - Remove /boot from {{mntFstab}}:
  #file.comment:
  mount.unmounted:
    - name: /boot
    - config: {{mntFstab}}
    - persist: True
    - require:
      - installFuntoo.mountingFilesystems - Mount btrfs /dev/sda as /mnt/funtoo

{{sls}} - Add / to {{mntFstab}}:
  mount.mounted:
    - name: /
    - mount: False
    - config: {{mntFstab}}
    - device: /dev/sda
    - fstype: btrfs
    - dump: 1
    - opts: rw,relatime,ssd,space_cache,subvolid=5,subvol=/
    - pass_num: 1
    - require:
      - installFuntoo.mountingFilesystems - Mount btrfs /dev/sda as /mnt/funtoo

{#
{{sls}} - Add /proc to {{mntFstab}}:
  mount.mounted:
    - name: /proc
    - mount: False
    - config: {{mntFstab}}
    - device: proc
    - fstype: proc
    - require:
      - installFuntoo.mountingFilesystems - Mount btrfs /dev/sda as /mnt/funtoo

{{sls}} - Add /sys to {{mntFstab}}:
  mount.mounted:
    - name: /sys
    - mount: False
    - config: {{mntFstab}}
    - device: /sys
    - fstype: sysfs
    - require:
      - installFuntoo.mountingFilesystems - Mount btrfs /dev/sda as /mnt/funtoo

{{sls}} - Add /dev to {{mntFstab}}:
  mount.mounted:
    - name: /dev
    - mount: False
    - config: {{mntFstab}}
    - device: /dev
    - fstype: devtmpfs
    - require:
      - installFuntoo.mountingFilesystems - Mount btrfs /dev/sda as /mnt/funtoo
#}

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
