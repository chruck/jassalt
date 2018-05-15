{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        bindMountDev,
        mountAsFuntoo,
        mntPt,
        with context %}

include:
  - .mountingFilesystems

{{sls}} - Mount {{mntPt}}/proc:
  mount.mounted:
    - name: {{mntPt}}/proc
    - device: proc
    - fstype: proc
    - mkmnt: True
    - require:
      - {{mountAsFuntoo}}

{{sls}} - Bind mount {{mntPt}}/sys:
  mount.mounted:
    - name: {{mntPt}}/sys
    - device: /sys
    - fstype: sysfs
    - mkmnt: True
    - opts: rbind
    - require:
      - {{mountAsFuntoo}}

{{bindMountDev}}:
  mount.mounted:
    - name: {{mntPt}}/dev
    - device: /dev
    - fstype: devtmpfs
    - mkmnt: True
    - opts: rbind
    - require:
      - {{mountAsFuntoo}}

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
