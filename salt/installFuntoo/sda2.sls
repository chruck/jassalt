{% if "sysresccd" == grains["nodename"] %}

{{sls}} - Format /dev/sda2:
  blockdev.formatted:
    - name: /dev/sda2
    - fs_type: btrfs

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
