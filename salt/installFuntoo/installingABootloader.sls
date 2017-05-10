{% if "sysresccd" == grains["nodename"] %}

{% set mntPt = "/mnt/funtoo" %}

include:
  - .downloadingThePortageTree

{{sls}} - Install grub:
  cmd.run:
    - name: /bin/chroot {{mntPt}} emerge boot-update
    - require:
      - installFuntoo.downloadingThePortageTree - Download Portage Tree

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
