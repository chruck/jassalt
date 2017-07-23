{% if "Gentoo" == grains.os %}

# From https://wiki.gentoo.org/wiki/Enlightenment :

include:
  - .useflags
#  - .acceptlicense

{{sls}} - Install Layman (for Enlightenment):
  pkg.installed:
    - name: app-portage/layman

{{sls}} - Configure Layman:
  file.replace:
    - name: /etc/layman/layman.cfg
    - pattern: check_official : Yes
    - repl: check_official : No
    - append_if_not_found: True
    - require:
      - {{sls}} - Install Layman (for Enlightenment)

{{sls}} - Add 'enlightenment-live' overlay with Layman:
  cmd.run:
    - name: layman -Nfa enlightenment-live
    - require:
      - {{sls}} - Install Layman (for Enlightenment)
      - {{sls}} - Configure Layman

{{sls}} - Install Enlightenment E21:
  pkg.installed:
    - name: enlightenment-core
    - version: 9999
    - require:
      - {{sls}} - Add 'enlightenment-live' overlay with Layman

{{sls}} - Create ~/.xinitrc:
  file.managed:
    - name: /home/{{pillar.user}}/.xinitrc
    - contents:
      - exec dbus-launch --exit-with-session enlightenment_start
    - require:
      - {{sls}} - Install Enlightenment E21

{% endif %}  # Gentoo
