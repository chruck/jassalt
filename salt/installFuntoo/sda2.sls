{% if "sysresccd" == grains["nodename"] %}

#{{sls}} - Label /dev/sda as GPT:
#  module.run:
#    - name: partition.mklabel
#    - device: /dev/sda
#    - label_type: gpt
#    - label_type: msdos

#{{sls}} - Create partition /dev/sda1 as fat32:
#  module.run:
#    - name: partition.mkpart
#    - device: /dev/sda
#    - part_type: primary
#    - fs_type: fat32
#    - start: 2048s
#    - end: 534527s
#    - start: 0
#    - end: 260

#{{sls}} - Create partition /dev/sda2 as btrfs:
#  module.run:
#    - name: partition.mkpart
#    - device: /dev/sda
#    - part_type: primary
#    - fs_type: btrfs
#    - start: 534528s
#    - end: -1s
#    - end: 1000215182s
#    - start: 260

{{sls}} - Format /dev/sda:
  cmd.run:
    - name: "mkfs.btrfs /dev/sda -f"

{{sls}} - Format /dev/sda:
  blockdev.formatted:
    - name: /dev/sda
    - fs_type: btrfs
    - force: True

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
