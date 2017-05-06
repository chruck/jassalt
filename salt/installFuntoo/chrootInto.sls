{% if "sysresccd" == grains["nodename"] %}

{% set mntPt = "/mnt/funtoo" %}

include:
  - .mountsda

{{sls}} - Copy /etc/resolv.conf to {{mntPt}}/etc:
  file.copy:
    - name: {{mntPt}}/etc/resolv.conf
    - source: /etc/resolv.conf
    - require:
      - mount: installFuntoo.mountsda - Mount btrfs /dev/sda as /mnt/funtoo

{{sls}} - Ping in chroot of {{mntPt}}:
  cmd.run:
    - name: /bin/chroot {{mntPt}} ping -c5 google.com
    - require:
      - file: {{sls}} - Copy /etc/resolv.conf to {{mntPt}}/etc

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
