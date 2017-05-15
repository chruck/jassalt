{% if "sysresccd" == grains["nodename"] %}

{% set mntPt = "/mnt/funtoo" %}
{% set makeConfFile = mntPt ~ "/etc/portage/make.conf" %}
{% set numThreads = grains["num_cpus"] + 1 %}

include:
  - .mountingFilesystems

{{sls}} - Set number of threads to {{numThreads}} in {{makeConfFile}} and USE to 'dbus', '-ppp', and '-modemmanager':
  file.append:
    - name: {{makeConfFile}}
    - text:
      - MAKEOPTS="-j{{numThreads}}"
      - USE="dbus -ppp -modemmanager"
    - require:
      - installFuntoo.mountingFilesystems - Mount btrfs /dev/sda as /mnt/funtoo

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
