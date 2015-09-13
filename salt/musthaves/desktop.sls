{% if 2015 > grains['saltversioninfo'][0] %}
{%   set tpldir = 'musthaves' %}
{%   set tplfile = tpldir ~ '/desktop.sls' %}
{% endif %}

{% set autoexpect = "expect-dev" %}
{% set chromium = "chromium-browser" %}
{% set ctags = "exuberant-ctags" %}
{% set display = "imagemagick" %}
{% set flash = "browser-plugin-gnash" %}
{% set gvim = "vim-gtk" %}
{% set irssiscripts = "irssi-scripts" %}
{% set xmllint = "libxml2-utils" %}

{{sls}} - Must-Haves for Desktop:
  pkg.latest:
    - refresh: True
    - install_recommends: False
    - pkgs:
      - antiword
      - {{autoexpect}}
      - {{chromium}}
      - clusterssh
      - {{ctags}}
      - {{display}}
      #- electricsheep
      - expect
      - firefox
      - {{flash}}
      - fossil
      - g++
      - gdb
      - gpm
      - {{gvim}}
      - irssi
      - {{irssiscripts}}
      - ncftp
      - {{xmllint}}
