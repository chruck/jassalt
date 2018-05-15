{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        harddriveDev,
        mntPt,
        with context %}

include:
  - .installingABootloader

{{sls}} - Install grub to MBR of {{harddriveDev}}:
  cmd.run:
    - name: /bin/chroot {{mntPt}} grub-install --target=i386-pc --no-floppy {{harddriveDev}}
    - require:
      - installFuntoo.installingABootloader - Install grub program

{{sls}} - Generate /boot/grub/grub.cfg:
  cmd.run:
    - name: /bin/chroot {{mntPt}} boot-update
    - require:
      - installFuntoo.installingABootloader - Update /etc/boot.conf

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
