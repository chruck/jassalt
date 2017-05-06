{% if "sysresccd" == grains["nodename"] %}

{% set mntPt = "/mnt/funtoo" %}

include:
  - .chrootInto

{{sls}} - Download Portage Tree:
  cmd.run:
    - name: /bin/chroot {{mntPt}} emerge --sync
    - require:
      - installFuntoo.chrootInto - Ping in chroot of {{mntPt}}

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
