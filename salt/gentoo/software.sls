{% if "Gentoo" == grains.os %}

include:
  - .useflags
  - .enlightenment
  - .sudo

{{sls}} - Use running kernel's config for next to build:
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

{{sls}} - Other Packages for Gentoo:
  pkg.installed:
    - refresh: True
#    - install_recommends: False
    - pkgs:
      - app-emulation/docker
      - media-fonts/corefonts
      - net-misc/ntp
      - net-print/cups
      - sys-power/pm-utils
      - www-plugins/adobe-flash
      - x11-apps/xinit
      - x11-base/xorg-x11
      - x11-drivers/nvidia-drivers
    - require:
      - {{sls}} - Use running kernel's config for next to build

{%      for svc in 'ntpd', 'cupsd', 'docker' %}
{{sls}} - Start {{svc}} service:
  service.running:
    - name: {{svc}}
    - enable: True
    - require:
      - {{sls}} - Other Packages for Gentoo
{%      endfor %}

{{sls}} - Kernel Source Package for Gentoo:
  pkg.installed:
    - name: sys-kernel/gentoo-sources
    - refresh: True
#    - install_recommends: False

{{sls}} - NVidia Package for Gentoo:
  pkg.installed:
    - name: x11-drivers/nvidia-drivers
    - refresh: True
#    - install_recommends: False
    - require:
      - {{sls}} - Use running kernel's config for next to build

{% endif %}  # Gentoo
