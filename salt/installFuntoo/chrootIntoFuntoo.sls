{% if "sysresccd" == grains["nodename"] %}

{% include "vars.jinja" %}
{#
{% set mntPt = "/mnt/funtoo" %}
#}

include:
  - .mountingFilesystems

{{sls}} - Copy /etc/resolv.conf to {{mntPt}}/etc:
  file.copy:
    - name: {{mntPt}}/etc/resolv.conf
    - source: /etc/resolv.conf
    - require:
      - installFuntoo.mountingFilesystems - Mount btrfs /dev/sda as /mnt/funtoo

{{sls}} - Ping in chroot of {{mntPt}}:
  cmd.run:
    - name: /bin/chroot {{mntPt}} ping -c5 google.com
    - require:
      - file: {{sls}} - Copy /etc/resolv.conf to {{mntPt}}/etc

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
