{% set ImageMagick = imagemagick %}
{% set ctags = exuberant-ctags %}
{% set autoexpect = expect-dev %}
{% set irssi-scripts = irssi-scripts %}
{% set xmllint = libxml2-utils %}

Must-Haves for Desktop:
  pkg.installed:
    - install_recommends: False
    - pkgs:
      - antiword
      - chromium
      - clusterssh
      - {{ ctags }}
      - {{ ImageMagick }}
      - electricsheep
      - expect
      - {{ autoexpect }}
      - firefox
      - fossil
      - g++
      - gdb
      - gpm
      - irssi
      - {{ irssi-scripts }}
      - ncftp
      - synergy
      - {{ xmllint }}
