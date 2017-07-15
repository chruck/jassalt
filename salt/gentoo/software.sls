{% if "Gentoo" == grains.os %}

include:
  - .useflags
  - .acceptlicense

{{sls}} - Other Packages for Gentoo:
  pkg.installed:
    - refresh: True
#    - install_recommends: False
    - pkgs:
      - x11-apps/xinit
      - cups

{% endif %}  # Gentoo
