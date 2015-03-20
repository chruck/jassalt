{% set man = "man-db" %}
{% set nslookup = "dnsutils" %}
{% set opensshd = "openssh-server" %}
{% set script = "bsdutils" %}
{% set tail = "coreutils" %}
{% set traceroute = "inetutils-traceroute" %}
{% set watch = "procps" %}

Must-Haves:
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
      - {{ man }}
      - {{ nslookup }}
      - {{ opensshd }}
      - pv
      - reptyr
      - rlwrap
      - rsync
      - screen
      - {{ script }}
      - sed
      - {{ tail }}
      - tcptraceroute
      - {{ traceroute }}
      - w3m
      - w3m-img
      - {{ watch }}
      - whois

# Separated out to satisfy another state
git:
  pkg.installed:
    - install_recommends: False

git-completion:
  pkg.installed:
    - install_recommends: False

git-doc:
  pkg.installed:
    - install_recommends: False

include:
  - .vim


Must-Not-Haves:
  pkg.purged:
    - pkgs:
      - nano
