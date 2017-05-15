{% if "sysresccd" == grains["nodename"] %}

{% set mntPt = "/mnt/funtoo" %}

include:
  - .mountVirtFs
#  - .downloadingThePortageTree
  - .configurationFiles-makeConf

{{sls}} - Install NetworkManager and Linux Firmware:
  cmd.run:
    - name: /bin/chroot {{mntPt}} emerge linux-firmware networkmanager
    - require:
#      - installFuntoo.downloadingThePortageTree - Download Portage Tree
      - installFuntoo.mountVirtFs - Bind mount {{mntPt}}/dev:
      - installFuntoo.configurationFiles-makeConf - Set number of threads to {{numThreads}} in {{makeConfFile}} and USE to 'dbus', '-ppp', and '-modemmanager':

{{sls}} - Start NetworkManager at startup:
  cmd.run:
    - name: /bin/chroot {{mntPt}} rc-update add NetworkManager default
    - require:
      - {{sls}} - Install NetworkManager and Linux Firmware

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
