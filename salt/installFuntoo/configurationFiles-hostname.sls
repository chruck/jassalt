{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        hostnameFile,
        mountingFilesystems,
        with context %}

include:
  - {{mountingFilesystems}}

{{sls}} - Set hostname in {{hostnameFile}}:
  file.managed:
    - name: {{hostnameFile}}
    - source: salt://{{tpldir}}/hostname
    - require:
      - {{mountingFilesystems}} - Mount btrfs /dev/sda as /mnt/funtoo

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
