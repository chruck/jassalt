{% if "Gentoo" == grains.os %}

include:
  - .useflags
#  - .acceptlicense
  - .enlightenment

{{sls}} - Other Packages for Gentoo:
  pkg.installed:
    - refresh: True
#    - install_recommends: False
    - pkgs:
      - app-admin/sudo
      - app-emulation/docker
      - media-fonts/corefonts
      - net-misc/ntp
      - net-print/cups
      - sys-kernel/gentoo-sources
      - www-plugins/adobe-flash
      - x11-apps/xinit
      - x11-base/xorg-x11
      - x11-drivers/nvidia-drivers

{%      for svc in 'ntpd', 'cupsd', 'docker' %}

{{sls}} - Start {{svc}} service:
  service.running:
    - name: {{svc}}
    - enable: True
    - require:
      - {{sls}} - Other Packages for Gentoo

{%      endfor %}

{% endif %}  # Gentoo
