{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        installStage3,
        mntPt,
        with context %}

include:
  - .installingTheStage3Tarball

{{sls}} - Patch to fake salt into thinking Funtoo is Gentoo:
  file.replace:
    - name:  {{mntPt}}/etc/os-release
    - pattern: Funtoo
    - repl: Gentoo
    - require:
      - {{installStage3}}

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
