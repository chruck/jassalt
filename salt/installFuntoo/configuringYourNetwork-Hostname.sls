{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        hostnameFile,
        mountAsFuntoo,
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
      - {{mountAsFuntoo}}

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
