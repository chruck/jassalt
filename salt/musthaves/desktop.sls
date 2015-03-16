{% set chromium = "chromium-browser" %}
{% set ctags = "exuberant-ctags" %}
{% set display = "imagemagick" %}
{% set autoexpect = "expect-dev" %}
{% set irssiscripts = "irssi-scripts" %}
{% set xmllint = "libxml2-utils" %}

Must-Haves for Desktop:
  pkg.installed:
    - install_recommends: False
    - pkgs:
      - antiword
      - {{ chromium }}
      - clusterssh
      - {{ ctags }}
      - {{ display }}
      #- electricsheep
      - expect
      - {{ autoexpect }}
      - firefox
      - fossil
      - g++
      - gdb
      - gpm
      - irssi
      - {{ irssiscripts }}
      - ncftp
      - synergy
      - {{ xmllint }}
