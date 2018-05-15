{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        mntPt,
        mountAsFuntoo,
        mountingFilesystems,
        with context %}

include:
  - {{mountingFilesystems}}

{{sls}} - Set root's password:
  file.replace:
    - name: {{mntPt}}/etc/shadow
    - pattern: 'root:\*:'
    - repl: 'root:$6$ncRpDhvOQ/5R4$EJThCxOVPZO8p1Nis558Jo6ICJkUwpXkPIRCaWS50dZHqKMMhQPphN/WP9dFwsRgf6yQIkY7z4hQsQveoveJu0:'
    - require:
      - {{mountAsFuntoo}}

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
