{% if "Gentoo" == grains.os %}

{% from tpldir ~ "/vars.jinja" import kernelConfig, kernelSrc with context %}

include:
  - .useflags
  - .enlightenment
  - .sudo
  - .kernel

{{sls}} - Other Packages for Gentoo:
  pkg.installed:
    - refresh: True
#    - install_recommends: False
    - pkgs:
      - app-emulation/docker
      - app-vim/vim-spell-en
      - media-fonts/corefonts
      - net-misc/ntp
      - net-misc/wicd
      - net-print/cups
      - sys-power/pm-utils
      - www-plugins/adobe-flash
      - x11-apps/xinit
      - x11-base/xorg-x11
#    - require:
#      - {{kernelConfig}}

{%      for svc in 'ntpd', 'cupsd', 'docker' %}
{{sls}} - Start {{svc}} service:
  service.running:
    - name: {{svc}}
    - enable: True
    - require:
      - {{sls}} - Other Packages for Gentoo
{%      endfor %}

{{sls}} - Intel Video Drivers:
  pkg.installed:
    - name: x11-drivers/xf86-video-intel
    - refresh: True
    - require:
      - gentoo.useflags - Set USE flags for libdrm

{% endif %}  # Gentoo
