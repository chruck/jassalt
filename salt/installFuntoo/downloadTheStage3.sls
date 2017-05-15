{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        mntPt,
        with context %}

{{sls}} - Install Funtoo Stage 3 onto {{mntPt}}:
  archive.extracted:
    - name: {{mntPt}}
    - source: http://build.funtoo.org/funtoo-current-hardened/pure64/intel64-haswell-pure64/stage3-latest.tar.xz
    - source_hash: http://build.funtoo.org/funtoo-current-hardened/pure64/intel64-haswell-pure64/stage3-latest.tar.xz.hash.txt

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
