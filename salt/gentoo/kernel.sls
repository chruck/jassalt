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

{{kernelConfig}}:
#  archive.extracted:
#    - name: /usr/src/linux/.config
#    - if_missing: /usr/src/linux/.config
#    - source: /proc/config.gz
#    - archive_format: tar
  cmd.run:
    - name: "zcat /proc/config.gz >/usr/src/linux/.config"
    - onlyif: "! test -e /usr/src/linux/.config"
    - require:
      - {{sls}} - Kernel Source Package for Gentoo

{{sls}} - Update old kernel config to latest format:
  cmd.run:
    - name: "cd /usr/src/linux; make oldconfig"
    - require:
      - {{kernelConfig}}

{{sls}} - Build and install kernel with genkernel:
  cmd.run:
    - name: "genkernel --no-mrproper all"
    - require:
      - {{sls}} - Update old kernel config to latest format
      - {{sls}} - Install 'genkernel'

{{sls}} - Now you should be able to reboot into new kernel:
  test.show_notification:
    - text:  Type 'reboot'

{% endif %}  # Gentoo
