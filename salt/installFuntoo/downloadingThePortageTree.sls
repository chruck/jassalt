{% if "sysresccd" == grains["nodename"] %}

{% set mntPt = "/mnt/funtoo" %}

include:
  - .chrootIntoFuntoo

{{sls}} - Download Portage Tree:
  cmd.run:
    - name: /bin/chroot {{mntPt}} emerge --sync
    - require:
      - installFuntoo.chrootIntoFuntoo - Ping in chroot of {{mntPt}}

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
