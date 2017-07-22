{% if "Gentoo" == grains.os %}

# From https://wiki.gentoo.org/wiki/Enlightenment :

include:
  - .useflags
#  - .acceptlicense

{{sls}} - Install Layman (for Enlightenment):
  pkg.installed:
    - name: layman

{{sls}} - Add 'enlightenment-live' overlay with Layman:
  cmd.shell:
    - name: layman -a enlightenment-live
    - require:
      - {{sls}} - Install Layman (for Enlightenment)

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
