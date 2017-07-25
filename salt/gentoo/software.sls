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
      - net-misc/ntp
      - net-print/cups
      - www-plugins/adobe-flash
      - x11-apps/xinit
      - x11-base/xorg-x11
      - x11-drivers/nvidia-drivers

{% endif %}  # Gentoo
