{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        installStage3,
        mntPt,
        mountingFilesystems,
        mountVirtFs,
        with context %}

include:
  - {{installingTheStage3Tarball}}
  - {{mountingFilesystems}}
  - {{mountVirtFs}}

{{sls}} - Copy /etc/resolv.conf to {{mntPt}}/etc:
  file.copy:
    - name: {{mntPt}}/etc/resolv.conf
    - source: /etc/resolv.conf
    - require:
      - {{mountingFilesystems}} - Mount btrfs /dev/sda as /mnt/funtoo
      - {{installStage3}}

{{sls}} - Ping in chroot of {{mntPt}}:
  cmd.run:
    - name: /bin/chroot {{mntPt}} ping -c5 google.com
    - require:
      - file: {{sls}} - Copy /etc/resolv.conf to {{mntPt}}/etc

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
