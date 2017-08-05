{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        emergeSync,
        mntPt,
        with context %}
{% from tpldir ~ "/headtail.jinja" import headtail with context %}

include:
  - .downloadingThePortageTree

{{sls}} - Install grub program:
  cmd.run:
    - name: /bin/chroot {{mntPt}} emerge boot-update {{headtail}}
    - require:
      - {{emergeSync}}

{{sls}} - Update /etc/boot.conf:
  file.managed:
    - name: {{mntPt}}/etc/boot.conf
    - source: salt://installFuntoo/boot.conf
    - require:
      - {{sls}} - Install grub program

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
