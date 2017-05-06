{% if "sysresccd" == grains["nodename"] %}

{{sls}} - Mount btrfs /dev/sda as /mnt/funtoo:
  mount.mounted:
    - name: /mnt/funtoo
    - device: /dev/sda
    - fstype: btrfs
    #- pass_num: 1
    - mkmnt: True

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
