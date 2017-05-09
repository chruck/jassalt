{% if "sysresccd" == grains["nodename"] %}

{% set mntPt = "/mnt/funtoo" %}
{% set makeConfFile = mntPt ~ "/etc/portage/make.conf" %}
{% set numThreads = grains["num_cpus"] + 1 %}

include:
  - .mountSda

{{sls}} - Set number of threads to {{numThreads}} in {{makeConfFile}}:
  file.append:
    - name: {{makeConfFile}}
    - text: MAKEOPTS="-j{{numThreads}}"
    - require:
      - mount: installFuntoo.mountSda - Mount btrfs /dev/sda as /mnt/funtoo

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
