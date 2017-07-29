{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        emergeSync,
        mntPt,
        with context %}

include:
  - {{downloadingThePortageTree}}

{{sls}} - Update @world:
  cmd.run:
    - name: /bin/chroot {{mntPt}} emerge -uDN @world
    - require:
      - {{emergeSync}}

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
