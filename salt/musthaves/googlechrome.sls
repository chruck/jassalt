{% from tpldir ~ "/map.jinja" import musthaves with context %}

include:
  - gentoo

{% if "Fedora" == grains.os %}

{{sls}} - Must-Haves for Desktop, Google Chrome repo (Fedora):
  pkgrepo.managed:
    - name: GoogleChrome
    - humanname: GoogleChrome
    - baseurl: http://dl.google.com/linux/chrome/rpm/stable/x86_64
    - gpgkey: https://dl-ssl.google.com/linux/linux_signing_key.pub
    - gpgcheck: 1
    - require_in:
      - {{sls}} - Must-Haves for Desktop, Google Chrome

{% if "Debian" == grains.os_family %}

{{sls}} - Must-Haves for Desktop, Google Chrome repo (Debian):
  pkgrepo.managed:
    - humanname: GoogleChrome
    #- name: deb http://dl.google.com/linux/chrome/deb/ stable main
    - name: deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
    - key_url: https://dl-ssl.google.com/linux/linux_signing_key.pub
    - file: /etc/apt/sources.list.d/google-chrome.list
    - dist: stable
    - gpgcheck: 1
    - require_in:
      - {{sls}} - Must-Haves for Desktop, Google Chrome

{% endif %}  # Distro

{{sls}} - Must-Haves for Desktop, Google Chrome:
  pkg.installed:
    - name: {{musthaves.chrome}}
    - refresh: True
#    - install_recommends: False
#    - uses: X
