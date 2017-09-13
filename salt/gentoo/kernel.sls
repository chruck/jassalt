{% if "Gentoo" == grains.os %}

{% from tpldir ~ "/vars.jinja" import kernelConfig, kernelSrc with context %}
{% from "installFuntoo/headtail.jinja" import headtail with context %}

{% set kernelName = "gentoo-sources" %}
{# set kernelName = "tuxonice-sources" #}

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

{{sls}} - Install 'intel-microcode':
  pkg.installed:
    - name: sys-firmware/intel-microcode
#    - require:
#      - {{sls}} - Set USE flags for genkernel

{{sls}} - Set USE flags for {{kernelName}}:
  portage_config.flags:
    - name: {{kernelName}}
    - use:
      - binary

{{kernelSrc}}:
  pkg.installed:
    - name: sys-kernel/{{kernelName}}
    - refresh: True
#    - install_recommends: False
    - require:
      - {{sls}} - Set USE flags for {{kernelName}}
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
      - {{kernelSrc}}

#{{sls}} - Update old kernel config to latest format:
#  cmd.run:
#    - name: "cd /usr/src/linux; make oldconfig {{headtail}}"
#    - require:
#      - {{kernelConfig}}

{{sls}} - Build and install kernel with genkernel:
  cmd.run:
    - name: "genkernel --no-color --oldconfig all {{headtail}}"
    - require:
#      - {{sls}} - Update old kernel config to latest format
      - {{sls}} - Install 'genkernel'

{{sls}} - NVidia Package for Gentoo:
  pkg.installed:
    - name: x11-drivers/nvidia-drivers
    - refresh: True
#    - install_recommends: False
    - require:
      - {{kernelSrc}}
      - {{sls}} - Build and install kernel with genkernel

{{sls}} - Execute 'boot-update':
  cmd.run:
    - name: boot-update
    - require:
#      - {{sls}} - Update old kernel config to latest format
      - {{sls}} - Install 'genkernel'
      - {{sls}} - Build and install kernel with genkernel

{{sls}} - Now you should be able to reboot into new kernel:
  test.show_notification:
    - text:  Type 'reboot'

{% endif %}  # Gentoo
