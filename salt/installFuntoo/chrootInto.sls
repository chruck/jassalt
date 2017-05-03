{% if "sysresccd" == grains["nodename"] %}

{% set mntPt = "/mnt/funtoo" %}

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
    - mkmnt: True
    - opts: rbind
    - require:
      - mount: installFuntoo.mountsda - Mount btrfs /dev/sda as /mnt/funtoo

{{sls}} - Bind mount {{mntPt}}/dev:
  mount.mounted:
    - name: {{mntPt}}/dev
    - device: /dev
    - mkmnt: True
    - opts: rbind
    - require:
      - mount: installFuntoo.mountsda - Mount btrfs /dev/sda as /mnt/funtoo

{{sls}} - Copy /etc/resolv.conf to {{mntPt}}/etc:
  file.copy:
    - name: {{mntPt}}/etc
    - source: /etc/resolv.conf
    - require:
      - mount: installFuntoo.mountsda - Mount btrfs /dev/sda as /mnt/funtoo

{{sls}} - Ping in chroot of {{mntPt}}:
  cmd.shell:
    - name: /bin/chroot {{mntPt}} ping -c5 google.com
    - require:
      - file: {{sls}} - Copy /etc/resolv.conf to {{mntPt}}/etc

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
