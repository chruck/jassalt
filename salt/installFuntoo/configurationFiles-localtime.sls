{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        mntPt,
        mountAsFuntoo,
        mountingFilesystems,
        localtimeFile,
        timezoneFile,
        with context %}

include:
  - {{mountingFilesystems}}

{{sls}} - Create symlink for {{localtimeFile}}:
  cmd.run:
    - name: /bin/chroot {{mntPt}} ln -sf {{timezoneFile}} {{localtimeFile}}
    - require:
      - {{mountAsFuntoo}}

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
