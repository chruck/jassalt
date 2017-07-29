{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        bindMountDev,
        chrootIntoFuntoo,
        emergeSync,
        mntPt,
        with context %}

include:
  - {{chrootIntoFuntoo}}

{{emergeSync}}:
  cmd.run:
    - name: "/bin/chroot {{mntPt}} emerge --sync |tail -n50"
    - require:
      - {{chrootIntoFuntoo}} - Ping in chroot of {{mntPt}}
      - {{bindMountDev}}

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
