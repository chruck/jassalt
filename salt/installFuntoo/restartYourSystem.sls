{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        mntPt,
        umountSda,
        with context %}

include:
  - {{umountSda}}

{{sls}} - Reboot:
  cmd.run:
    - name: reboot
    - require:
      - mount: {{umountSda}} - Unmount {{mntPt}}

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
