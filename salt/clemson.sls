{% set baseURL = "salt://clemson" %}

{{baseURL}} - Install packages to use with Clemson systems:
  pkg.installed:
    - install_recommends: False
    - pkgs:
      - openconnect
      - subversion
      - rdesktop

{{baseURL}} - Download Clemson binaries:
  git.latest:
    - name: https://github.com/eckardclemson/bin.git
    - target: /home/jas/src/bin
    - require:
      - pkg: git
