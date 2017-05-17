{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        mntPt,
        mountVirtFs,
        downloadingThePortageTree,
        with context %}

include:
  - {{mountVirtFs}}
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

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
