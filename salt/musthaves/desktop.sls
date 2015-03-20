{% set autoexpect = "expect-dev" %}
{% set chromium = "chromium-browser" %}
{% set ctags = "exuberant-ctags" %}
{% set display = "imagemagick" %}
{% set gvim = "vim-gtk" %}
{% set irssiscripts = "irssi-scripts" %}
{% set xmllint = "libxml2-utils" %}

Must-Haves for Desktop:
  pkg.installed:
    - install_recommends: False
    - pkgs:
      - antiword
      - {{ autoexpect }}
      - {{ chromium }}
      - clusterssh
      - {{ ctags }}
      - {{ display }}
      #- electricsheep
      - expect
      - firefox
      - fossil
      - g++
      - gdb
      - gpm
      - {{ gvim }}
      - irssi
      - {{ irssiscripts }}
      - ncftp
      - synergy
      - {{ xmllint }}
