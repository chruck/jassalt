{% if "sysresccd" == grains["nodename"] %}

{{sls}} - Format /dev/sda:
  blockdev.formatted:
    - name: /dev/sda
    - fs_type: btrfs

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'.":
  cmd.run
{% endif %}
