{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        bindMountDev,
        downloadingThePortageTree,
        emergeSync,
        futureHostname,
        mntPt,
        mountVirtFs,
        mountingFilesystems,
        saltMasterHostname,
        saltMasterIp,
        with context %}
{% from tpldir ~ "/headtail.jinja" import headtail with context %}

include:
  - {{mountVirtFs}}
  - {{mountingFilesystems}}
  - {{downloadingThePortageTree}}

{{sls}} - Install Salt:
  cmd.run:
    - name: "/bin/chroot {{mntPt}} emerge salt {{headtail}}"
    - require:
      - {{emergeSync}}
      - {{bindMountDev}}

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
      - {{mountingFilesystems}} - Mount btrfs /dev/sda as /mnt/funtoo

# Commented out, seeing if setting 'hostname' takes care of this:
#{{sls}} - Set the minion id:
#  file.managed:
#    - name: {{mntPt}}/etc/salt/minion_id
#    - text:
#      - {{futureHostname}}
#    - require:
#      - {{sls}} - Install Salt

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
