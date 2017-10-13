{% if "Gentoo" == grains.os %}

include:
  - .useflags
  - adduser
  - sudoInsult

{{sls}} - Set USE flags for sudo:
  portage_config.flags:
    - name: sudo
    - use:
      - offensive

{{sls}} - Sudo Package for Gentoo:
  pkg.installed:
    - name: app-admin/sudo
    - refresh: True
#    - install_recommends: False
    - require:
      - {{sls}} - Set USE flags for sudo
    - require_in:
      - sudoInsult - Set sudo to insult you when you put in a bad password
      - adduser - Give eckard full sudo access

{% endif %}  # Gentoo
