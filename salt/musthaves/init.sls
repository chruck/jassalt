{% set baseURL = "salt://musthaves" %}

{% set man = "man-db" %}
{% set nslookup = "dnsutils" %}
{% set opensshd = "openssh-server" %}
{% set script = "bsdutils" %}
{% set tail = "coreutils" %}
{% set traceroute = "inetutils-traceroute" %}
{% set watch = "procps" %}

{{baseURL}} - Must-Haves:
  pkg.installed:
    - install_recommends: False
    - pkgs:
      - bash
      - bash-completion
      - di
      - elinks
      - grep
      - indent
      - info
      - less
      - links
      - locate
      - lynx
      - make
      - {{man}}
      - {{nslookup}}
      - {{opensshd}}
      - pv
      - reptyr
      - rlwrap
      - rsync
      - screen
      - {{script}}
      - sed
      - {{tail}}
      - tcptraceroute
      - {{traceroute}}
      - w3m
      - w3m-img
      - {{watch}}
      - whois

include:
  - .git
  - .vim

{{baseURL}} - Must-Not-Haves:
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
      - libtimezonemap1
      - libvte-2.90-9
      - libvte-2.90-common
      - python3-cairo
      - python3-gi-cairo
      - libcrypto++9
      # end "no longer required"
