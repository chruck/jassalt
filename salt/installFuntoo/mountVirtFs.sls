{% if "sysresccd" == grains["nodename"] %}

{% set mntPt = "/mnt/funtoo" %}

include:
  - .mountingFilesystems

{{sls}} - Mount {{mntPt}}/proc:
  mount.mounted:
    - name: {{mntPt}}/proc
    - device: proc
    - fstype: proc
    - mkmnt: True
    - require:
      - installFuntoo.mountingFilesystems - Mount btrfs /dev/sda as /mnt/funtoo

{{sls}} - Bind mount {{mntPt}}/sys:
  mount.mounted:
    - name: {{mntPt}}/sys
    - device: /sys
    - fstype: sysfs
    - mkmnt: True
    - opts: rbind
    - require:
      - installFuntoo.mountingFilesystems - Mount btrfs /dev/sda as /mnt/funtoo

{{sls}} - Bind mount {{mntPt}}/dev:
  mount.mounted:
    - name: {{mntPt}}/dev
    - device: /dev
    - fstype: devtmpfs
    - mkmnt: True
    - opts: rbind
    - require:
      - installFuntoo.mountingFilesystems - Mount btrfs /dev/sda as /mnt/funtoo

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
