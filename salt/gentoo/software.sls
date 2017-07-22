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
      - net-print/cups
      - x11-apps/xinit
      - x11-base/xorg-x11

{% endif %}  # Gentoo
