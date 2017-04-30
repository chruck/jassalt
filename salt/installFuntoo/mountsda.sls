{% if "sysresccd" == grains["nodename"] %}

include:
  - .sda2

{{sls}} - Mount btrfs /dev/sda2 as /mnt/funtoo:
  mount.mounted:
    - name: /mnt/funtoo
    - device: /dev/sda2
    - fstype: btrfs
    #- pass_num: 1
    - mkmnt: True
    - require:
      - blockdev: installFuntoo.sda2 - Format /dev/sda2

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
