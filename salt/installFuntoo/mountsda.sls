{% if "sysresccd" == grains["nodename"] %}

include:
  - .sda

{{sls}} - Mount btrfs /dev/sda as /mnt/funtoo:
  mount.mounted:
    - name: /mnt/funtoo
    - device: /dev/sda
    - fstype: btrfs
    #- pass_num: 1
    - mkmnt: True
    - require:
      - blockdev: installFuntoo.sda - Format /dev/sda

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
