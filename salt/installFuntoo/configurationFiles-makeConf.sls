{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        mntPt,
        makeConfFile,
        mountingFilesystems,
        numThreads,
        with context %}

include:
  - {{mountingFilesystems}}

{{sls}} - Set MAKEOPTS, USE, and CFLAGS in {{makeConfFile}}:
  file.managed:
    - name: {{makeConfFile}}
    - source: salt://gentoo/make.conf
    - defaults:
        numThreads: {{numThreads}}
    - require:
      - {{mountingFilesystems}} - Mount btrfs /dev/sda as /mnt/funtoo

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
