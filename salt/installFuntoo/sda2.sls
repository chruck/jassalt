{% if "sysresccd" == grains["nodename"] %}

{{sls}} - Label /dev/sda as GPT:
  module.run:
    - name: partition.mklabel
    - device: /dev/sda
    - label_type: gpt

{{sls}} - Create partition /dev/sda1 as fat32:
  module.run:
    - name: partition.mkpart
    - device: /dev/sda
    - part_type: primary
    - fs_type: fat32
    - start: 2048s
    - end: 534527s

{{sls}} - Create partition /dev/sda2 as btrfs:
  module.run:
    - name: partition.mkpart
    - device: /dev/sda
    - part_type: primary
#    - fs_type: btrfs
    - start: 534528s
#    - end: -1s
    - end: 1000215215s

{{sls}} - Format /dev/sda2:
  blockdev.formatted:
    - name: /dev/sda2
    - fs_type: btrfs

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
