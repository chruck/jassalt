{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        mntPt,
        mountingFilesystems,
        futureHostname,
        with context %}

include:
  - {{mountingFilesystems}}

{{sls}} - Change hostname to '{{futureHostname}}':
  file.replace:
    - name: {{mntPt}}/etc/conf.d/hostname
    - pattern: "HOSTNAME=.*"
    - repl: "HOSTNAME={{futureHostname}}"
    - require:
      - mount: {{mountingFilesystems}} - Mount btrfs /dev/sda as /mnt/funtoo

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
