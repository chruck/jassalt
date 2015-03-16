{% set opensshd = "openssh-server" %}
{% set man = "man-db" %}
{% set nslookup = "dnsutils" %}
{% set script = "bsdutils" %}
{% set tail = "coreutils" %}
{% set traceroute = "inetutils-traceroute" %}
{% set vimdoc = "vim-doc" %}
{% set vimscripts = "vim-scripts" %}
{% set gvim = "vim-gtk" %}
{% set vimaddonmanager = "vim-addon-manager" %}
{% set watch = "procps" %}

Must-Haves:
  pkg.installed:
    - install_recommends: False
    - pkgs:
      - bash
      - bash-completion
      - di
      - grep
      - indent
      - less
      - locate
      - lynx
      - links
      - elinks
      - w3m
      - w3m-img
      - make
      - {{ man }}
      - info
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
      - {{ traceroute }}
      - tcptraceroute
      - vim
      - {{ gvim }}
      - {{ vimdoc }}
      - {{ vimscripts }}
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

{{ vimaddonmanager }}:
  pkg.installed:
    - install_recommends: False

Install Vim addons:
  cmd.wait:
    - name: vim-addons install -w info jinja matchit omnicppcomplete xmledit
    - watch:
      - pkg: {{ vimaddonmanager }}


Must-Not-Haves:
  pkg.purged:
    - pkgs:
      - nano
