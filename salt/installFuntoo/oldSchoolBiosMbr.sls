{% if "sysresccd" == grains["nodename"] %}

{% set mntPt = "/mnt/funtoo" %}

include:
  - .installingABootloader

{{sls}} - Install grub to MBR of /dev/sda:
  cmd.run:
    - name: /bin/chroot {{mntPt}} grub-install --target=i386-pc --no-floppy /dev/sda
    - require:
      - installFuntoo.installingABootloader - Install grub

{{sls}} - Generate /boot/grub/grub.cfg:
  cmd.run:
    - name: /bin/chroot {{mntPt}} boot-update
    - require:
      - installFuntoo.installingABootloader - Update /etc/boot.conf

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
