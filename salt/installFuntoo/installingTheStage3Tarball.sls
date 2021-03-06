{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        installStage3,
        mntPt,
        with context %}
{% from tpldir ~ "/headtail.jinja" import headtail with context %}

# Prefer cmd.run below, since trim_output doesn't work and output
# still scrolls off the screen
#{{installStage3}}:
#  archive.extracted:
#    - name: {{mntPt}}
#    - source: http://build.funtoo.org/funtoo-current-hardened/pure64/intel64-haswell-pure64/stage3-latest.tar.xz
#    - source_hash: http://build.funtoo.org/funtoo-current-hardened/pure64/intel64-haswell-pure64/stage3-latest.tar.xz.hash.txt
#    - options: p
#    - trim_output: True

{{installStage3}}:
  cmd.run:
    - name: "cd {{mntPt}} ; wget -nv -O - http://build.funtoo.org/funtoo-current-hardened/pure64/intel64-haswell-pure64/stage3-latest.tar.xz | tar xvpJf - {{headtail}}"

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
