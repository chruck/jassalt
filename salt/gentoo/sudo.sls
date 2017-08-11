{% if "Gentoo" == grains.os %}

include:
  - .useflags
  - adduser
  - sudoInsult

{{sls}} - Sudo Package for Gentoo:
  pkg.installed:
    - name: app-admin/sudo
    - refresh: True
#    - install_recommends: False
    - require_in:
      - sudoInsult - Set sudo to insult you when you put in a bad password
      - adduser - Give eckard full sudo access

{% endif %}  # Gentoo
