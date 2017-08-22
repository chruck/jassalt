{% if "Gentoo" == grains.os %}

{% from tpldir ~ "/vars.jinja" import kernelConfig, kernelSrc with context %}

include:
  - .useflags

{{sls}} - Set USE flags for genkernel:
  portage_config.flags:
    - name: genkernel
    - use:
      - "-cryptsetup"

{{sls}} - Install 'genkernel':
  pkg.installed:
    - name: sys-kernel/genkernel
    - require:
      - {{sls}} - Set USE flags for genkernel

{{sls}} - Set USE flags for gentoo-sources:
  portage_config.flags:
    - name: gentoo-sources
    - use:
      - binary

{{kernelSrc}}:
  pkg.installed:
    - name: sys-kernel/gentoo-sources
    - refresh: True
#    - install_recommends: False
    - require:
      - {{sls}} - Set USE flags for gentoo-sources
      - {{sls}} - Install 'genkernel'

#{{kernelConfig}}:
##  archive.extracted:
##    - name: /usr/src/linux/.config
##    - if_missing: /usr/src/linux/.config
##    - source: /proc/config.gz
##    - archive_format: tar
#  cmd.run:
#    - name: "cd /usr/src/linux
#             && cp /proc/config.gz .
#             && gunzip config.gz
#             && mv config .config"
#    - onlyif: "! test -e /usr/src/linux/.config"
#    - require:
#      - {{sls}} - Kernel Source Package for Gentoo

{% endif %}  # Gentoo
