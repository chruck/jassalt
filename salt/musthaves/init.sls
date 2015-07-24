{% from tpldir ~ "/map.jinja" import musthaves with context %}

{{tplfile}} - Must-Haves:
  pkg.latest:
    - install_recommends: False
    - pkgs:
      - bash
      - bash-completion
      - coreutils
      - grep
      - indent
      - info
      - less
      - links
      - lynx
      - make
      - procps
      - pv
      - reptyr
      - rlwrap
      - rsync
      - screen
      - sed
      - w3m
      {% for pkg in musthaves.pkglist %}
      - {{pkg}}
      {% endfor %}

include:
  - .git
  - .vim

{{tplfile}} - Must-Not-Haves:
  pkg.purged:
    - pkgs:
      - nano
      - ppp
{% if salt["grains.get"]("virtual", "physical") %}
      - virtualbox-guest-dkms
      - virtualbox-guest-utils
      - virtualbox-guest-x11
      - libspice-server1
{% endif %}
      # This list from Bodhi installation to "apt upgrade" listed as "no
      # longer required":
      - gir1.2-appindicator3-0.1
      - gir1.2-javascriptcoregtk-3.0
      - gir1.2-json-1.0
      - gir1.2-soup-2.4
      - gir1.2-timezonemap-1.0
      - gir1.2-vte-2.90
      - gir1.2-webkit-3.0
      - gir1.2-xkl-1.0
      - ieee-data
      - libcrypto++9
      - libjs-jquery-metadata
      - libjs-jquery-tablesorter
      - libjs-modernizr
      - libjs-twitter-bootstrap
      - libtimezonemap1
      - libvte-2.90-9
      - libvte-2.90-common
      - linux-headers-3.16.0-31
      - linux-headers-3.16.0-31-generic
      - linux-image-3.16.0-31-generic
      - linux-image-extra-3.16.0-31-generic
      - python3-cairo
      - python3-gi-cairo
      # end "no longer required"
