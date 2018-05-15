{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        mountAsFuntoo,
        mntPt,
        mntDev,
        with context %}

{{mountAsFuntoo}}:
  mount.mounted:
    - name: {{mntPt}}
    - device: {{mntDev}}
    - fstype: btrfs
    #- pass_num: 1
    - mkmnt: True

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
