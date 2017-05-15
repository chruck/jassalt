{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        mntPt,
        mountVirtFs,
        configurationFiles-makeConf,
        with context %}

include:
  - {{mountVirtFs}}
#  - {{downloadingThePortageTree}}
  - {{configurationFiles-makeConf}}

{{sls}} - Install NetworkManager and Linux Firmware:
  cmd.run:
    - name: /bin/chroot {{mntPt}} emerge linux-firmware networkmanager
    - require:
#      - {{downloadingThePortageTree}} - Download Portage Tree
      - {{mountVirtFs}} - Bind mount {{mntPt}}/dev:
      - {{configurationFiles-makeConf}} - Set number of threads to {{numThreads}} in {{makeConfFile}} and USE to 'dbus', '-ppp', and '-modemmanager':

{{sls}} - Start NetworkManager at startup:
  cmd.run:
    - name: /bin/chroot {{mntPt}} rc-update add NetworkManager default
    - require:
      - {{sls}} - Install NetworkManager and Linux Firmware

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
