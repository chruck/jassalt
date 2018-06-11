{% from tpldir ~ "/map.jinja" import musthaves with context %}

include:
  - gentoo

{% if "Fedora" == grains.os %}

{{sls}} - Must-Haves for Desktop, Google Chrome:
  pkgrepo.managed:
    - humanname: Google Chrome
    - baseurl: http://dl.google.com/linux/chrome/rpm/stable/x86_64
    - gpgkey: https://dl-ssl.google.com/linux/linux_signing_key.pub
    - gpgcheck: 1
    - require_in:
      - {{sls}} - Must-Haves for Desktop, Google Chrome

{% endif %}  # Fedora

{{sls}} - Must-Haves for Desktop, Google Chrome:
  pkg.installed:
    - name: {{musthaves.chrome}}
    - refresh: True
#    - install_recommends: False
#    - uses: X
