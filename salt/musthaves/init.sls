{% from tpldir ~ "/map.jinja" import musthaves with context %}

include:
  - .git
  - .vim
  - .salt-minion

{{sls}} - Must-Haves:
  pkg.install:
    - refresh: True
#    - install_recommends: False
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

{{sls}} - Must-Not-Haves:
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
      - diffstat
      - dkms
      - gettext
      - gir1.2-appindicator3-0.1
      - gir1.2-javascriptcoregtk-3.0
      - gir1.2-json-1.0
      - gir1.2-soup-2.4
      - gir1.2-timezonemap-1.0
      - gir1.2-vte-2.90
      - gir1.2-webkit-3.0
      - gir1.2-xkl-1.0
      - hardening-includes
      - ieee-data
      - intltool-debian
      - libapt-pkg-perl
      - libarchive-zip-perl
      - libasprintf-dev
      - libclone-perl
      - libcrypto++9
      - libemail-valid-perl
      - libgettextpo-dev
      - libgettextpo0
      - libio-pty-perl
      - libipc-run-perl
      - libipc-system-simple-perl
      - libjs-jquery-metadata
      - libjs-jquery-tablesorter
      - libjs-modernizr
      - libjs-sphinxdoc
      - libjs-twitter-bootstrap
      - libjs-underscore
      - liblist-moreutils-perl
      - libnet-dns-perl
      - libnet-domain-tld-perl
      - libnet-ip-perl
      - libperlio-gzip-perl
      - libsub-identify-perl
      - libtext-levenshtein-perl
      - libtimezonemap1
      - libunistring0
      - libvte-2.90-9
      - libvte-2.90-common
      - lintian
      - linux-headers-3.16.0-31
      - linux-headers-3.16.0-31-generic
      - linux-image-3.16.0-31-generic
      - linux-image-extra-3.16.0-31-generic
      - patchutils
      - python3-cairo
      - python3-gi-cairo
      # end "no longer required"
