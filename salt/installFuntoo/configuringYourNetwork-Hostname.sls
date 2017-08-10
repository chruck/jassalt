{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        hostnameFile,
        mountingFilesystems,
        futureHostname,
        with context %}

include:
  - {{mountingFilesystems}}

{{sls}} - Change hostname to '{{futureHostname}}':
  file.replace:
    - name: {{hostnameFile}}
    - pattern: "hostname=.*"
    - repl: "hostname={{futureHostname}}"
    - require:
      - {{mountingFilesystems}} - Mount btrfs /dev/sda as /mnt/funtoo

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
