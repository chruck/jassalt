{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        mountingFilesystems,
        with context %}

include:
  - {{mountingFilesystems}}

{{sls}} - Set root's password:
  user.present:
    - name: root
    - password: $6$ncRpDhvOQ/5R4$EJThCxOVPZO8p1Nis558Jo6ICJkUwpXkPIRCaWS50dZHqKMMhQPphN/WP9dFwsRgf6yQIkY7z4hQsQveoveJu0
    - require:
      - mount: {{mountingFilesystems}} - Mount btrfs /dev/sda as /mnt/funtoo

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
