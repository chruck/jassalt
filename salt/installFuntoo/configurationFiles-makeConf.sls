{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        mntPt,
        makeConfFile,
        mountAsFuntoo,
        mountingFilesystems,
        numThreads,
        with context %}

include:
  - {{mountingFilesystems}}

{{sls}} - Set MAKEOPTS, USE, and CFLAGS in {{makeConfFile}}:
  file.managed:
    - name: {{makeConfFile}}
    - source: salt://gentoo/make.conf
    - template: jinja
    - defaults:
        numThreads: {{numThreads}}
    - require:
      - {{mountAsFuntoo}}

#{{sls}} - Set USE flag for consolekit:
#  portage_config.flags:
#    - name: ">=sys-auth/consolekit-1.0.1"
#    - use:
#      - policykit

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
