Must-Haves:
  pkg.installed:
    - install_recommends: False
    - pkgs:
      - bash
      - bash-completion
      - di
      - git
      - git-completion
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
      - man
      - info
      - nslookup
      - opensshd
      - pv
      - reptyr
      - rlwrap
      - rsync
      - screen
      - script
      - sed
      - tail
      - traceroute
      - tcptraceroute
      - vim
      - gvim
      - procps
      - whois

Must-Not-Haves:
  pkg.purged:
    - pkgs:
      - nano
