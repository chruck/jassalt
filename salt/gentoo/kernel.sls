{% if "Gentoo" == grains.os %}

{% from tpldir ~ "/vars.jinja" import kernelConfig with context %}

include:
  - .useflags

{{sls}} - Kernel Source Package for Gentoo:
  pkg.installed:
    - name: sys-kernel/gentoo-sources
    - refresh: True
#    - install_recommends: False

{{kernelConfig}}:
#  archive.extracted:
#    - name: /usr/src/linux/.config
#    - if_missing: /usr/src/linux/.config
#    - source: /proc/config.gz
#    - archive_format: tar
  cmd.run:
    - name: "cd /usr/src/linux
             && cp /proc/config.gz .
             && gunzip config.gz
             && mv config .config"
    - require:
      - {{sls}} - Kernel Source Package for Gentoo

{% endif %}  # Gentoo
