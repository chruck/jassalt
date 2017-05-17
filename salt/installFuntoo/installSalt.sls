{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        mntPt,
        mountVirtFs,
	mountingFilesystems,
        downloadingThePortageTree,
        saltMasterHostname,
        saltMasterIp,
        with context %}

include:
  - {{mountVirtFs}}
  - {{mountingFilesystems}}
#  - {{downloadingThePortageTree}}

{{sls}} - Install Salt:
  cmd.run:
    - name: /bin/chroot {{mntPt}} emerge salt
    - require:
#      - {{downloadingThePortageTree}} - Download Portage Tree
      - mount: {{mountVirtFs}} - Bind mount {{mntPt}}/dev

{{sls}} - Start salt-minion at startup:
  cmd.run:
    - name: /bin/chroot {{mntPt}} rc-update add salt-minion default
    - require:
      - {{sls}} - Install Salt

{{sls}} - Add tiger to /etc/hosts and alias it to 'salt':
  file.append:
    - name: {{mntPt}}/etc/hosts
    - text:
      - "{{saltMasterIp}} {{saltMasterHostname}} salt"
    - require:
      - mount: {{mountingFilesystems}} - Mount btrfs /dev/sda as /mnt/funtoo

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
