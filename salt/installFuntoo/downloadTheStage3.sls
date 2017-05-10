{% if "sysresccd" == grains["nodename"] %}

{{sls}} - Install Funtoo Stage 3 onto /mnt/funtoo:
  archive.extracted:
    - name: /mnt/funtoo
    - source: http://build.funtoo.org/funtoo-current-hardened/pure64/intel64-haswell-pure64/stage3-latest.tar.xz
    - source_hash: http://build.funtoo.org/funtoo-current-hardened/pure64/intel64-haswell-pure64/stage3-latest.tar.xz.hash.txt

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
