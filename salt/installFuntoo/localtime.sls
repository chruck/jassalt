{% if "sysresccd" == grains["nodename"] %}

{% set mntPt = "/mnt/funtoo" %}
{% set localtimeFile = "/etc/localtime" %}
{% set timezoneFile = "/usr/share/zoneinfo/EST5EDT" %}

include:
  - .mountingFilesystems

{{sls}} - Create symlink for {{localtimeFile}}:
  cmd.run:
    - name: /bin/chroot {{mntPt}} ln -sf {{timezoneFile}} {{localtimeFile}}
    - require:
      - installFuntoo.mountingFilesystems - Mount btrfs /dev/sda as /mnt/funtoo

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
