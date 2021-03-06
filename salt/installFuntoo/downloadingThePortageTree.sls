{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        bindMountDev,
        chrootIntoFuntoo,
        emergeSync,
        mntPt,
        mountVirtFs,
        with context %}
{% from tpldir ~ "/headtail.jinja" import headtail with context %}

include:
  - {{chrootIntoFuntoo}}
  - {{mountVirtFs}}

{{emergeSync}}:
  cmd.run:
#    - name: "/bin/chroot {{mntPt}} sh -c 'emerge --sync >/tmp/emerge-sync; rc=$?; tail -n50 /tmp/emerge-sync; exit $rc'"
    - name: "/bin/chroot {{mntPt}} ego sync {{headtail}}"
    - require:
      - {{chrootIntoFuntoo}} - Ping in chroot of {{mntPt}}
      - {{bindMountDev}}

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
