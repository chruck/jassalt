{% if "sysresccd" == grains["nodename"] %}

{% set mntPt = "/mnt/funtoo" %}

include:
  - .mountsda

{{sls}} - Mount {{mntPt}}/proc:
  mount.mounted:
    - name: {{mntPt}}/proc
    - device: proc
    - fstype: proc
    - mkmnt: True
    - require:
      - mount: installFuntoo.mountsda - Mount btrfs /dev/sda as /mnt/funtoo

{{sls}} - Bind mount {{mntPt}}/sys:
  mount.mounted:
    - name: {{mntPt}}/sys
    - device: /sys
    - fstype: sysfs
    - mkmnt: True
    - opts: rbind
    - require:
      - mount: installFuntoo.mountsda - Mount btrfs /dev/sda as /mnt/funtoo

{{sls}} - Bind mount {{mntPt}}/dev:
  mount.mounted:
    - name: {{mntPt}}/dev
    - device: /dev
    - fstype: devtmpfs
    - mkmnt: True
    - opts: rbind
    - require:
      - mount: installFuntoo.mountsda - Mount btrfs /dev/sda as /mnt/funtoo

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
