{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        mntPt,
        makeConfFile,
        mountingFilesystems,
        numThreads,
        with context %}

include:
  - {{mountingFilesystems}}

{{sls}} - Set number of threads to {{numThreads}} in {{makeConfFile}} and USE to 'dbus', '-ppp', and '-modemmanager':
  file.append:
    - name: {{makeConfFile}}
    - text:
      - MAKEOPTS="-j{{numThreads}}"
      - USE="dbus -ppp -modemmanager"
    - require:
      - {{mountingFilesystems}} - Mount btrfs /dev/sda as /mnt/funtoo

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
