{% if "sysresccd" == grains["nodename"] %}

{% set mntPt = "/mnt/funtoo" %}

include:
  - .downloadingThePortageTree

{{sls}} - Install grub:
  cmd.run:
    - name: /bin/chroot {{mntPt}} emerge boot-update
    - require:
      - installFuntoo.downloadingThePortageTree - Download Portage Tree

{{sls}} - Update /etc/boot.conf:
  file.managed:
    - name: {{mntPt}}/etc/boot.conf
    - source: salt://installFuntoo/boot.conf
    - require:
      - {{sls}} - Install grub

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
