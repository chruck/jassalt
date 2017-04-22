{% if "sysresccd" == grains["nodename"] %}

{{sls}} - Format /dev/sda:
  blockdev.formatted:
    - name: /dev/sda
    - fs_type: btrfs

{% endif %}
