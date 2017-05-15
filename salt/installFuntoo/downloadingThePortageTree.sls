{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        mntPt,
        chrootIntoFuntoo,
        with context %}

include:
  - {{chrootIntoFuntoo}}

{{sls}} - Download Portage Tree:
  cmd.run:
    - name: /bin/chroot {{mntPt}} emerge --sync
    - require:
      - {{chrootIntoFuntoo}} - Ping in chroot of {{mntPt}}

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
