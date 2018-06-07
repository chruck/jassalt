{% from tpldir ~ "/map.jinja" import musthaves with context %}

include:
  - gentoo

{% if "Fedora" == grains.os %}

{{sls}} - Must-Haves for Desktop, VLC repo:
  pkg.installed:
    - name: https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-{{grains.osrelease}}.noarch.rpm
    - refresh: True
    - require_in:
      - {{sls}} - Must-Haves for Desktop, vlc

{% endif %}  # Fedora

{{sls}} - Must-Haves for Desktop, vlc:
  pkg.installed:
    - name: {{musthaves.vlc}}
    - refresh: True
#    - install_recommends: False
#    - uses: X
