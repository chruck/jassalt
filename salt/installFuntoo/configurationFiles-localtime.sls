{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        mntPt,
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
      - {{mountingFilesystems}} - Mount btrfs /dev/sda as /mnt/funtoo

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
