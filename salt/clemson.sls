{% set baseURL = "salt://clemson" %}

{{baseURL}} - Install packages to use with Clemson systems:
  pkg.installed:
    - install_recommends: False
    - pkgs:
      - openconnect
      - subversion
      - rdesktop
