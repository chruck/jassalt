{% if "Gentoo" == grains.os %}

{% from "installFuntoo/headtail.jinja" import headtail with context %}

# From https://wiki.gentoo.org/wiki/Enlightenment :

include:
  - .useflags
#  - .acceptlicense

{{sls}} - Install Layman (for Enlightenment):
  pkg.installed:
    - name: app-portage/layman

#{{sls}} - Configure Layman:
#  file.replace:
#    - name: /etc/layman/layman.cfg
#    - pattern: "check_official : Yes"
#    - repl: "check_official : No"
#    - append_if_not_found: True
#    - require:
#      - {{sls}} - Install Layman (for Enlightenment)
#
{{sls}} - Add 'enlightenment-live' overlay with Layman:
#  cmd.run:
#    - name: layman -Nfa enlightenment-live
#    - onlyif: '! ( layman -l |grep enlightenment-live )'
#    - require:
#      - {{sls}} - Install Layman (for Enlightenment)
#      - {{sls}} - Configure Layman
  layman.present:
    - name: enlightenment-live

#{{sls}} - Generate metadata for 'enlightenment-live' overlay:
#  cmd.run:
#    - name: 'egencache --repo=enlightenment-live --update'
#    - require:
#      - {{sls}} - Add 'enlightenment-live' overlay with Layman

{{sls}} - Set USE flags for eterm:
  portage_config.flags:
    - name: eterm
    - use:
      - escreen

{{sls}} - Set USE flags for efl:
  portage_config.flags:
    - name: efl
    - use:
      - drm

{{sls}} - Create keywords directory for Portage:
  file.directory:
    - name: /etc/portage/package.keywords

{{sls}} - Install dependancy packages:
  pkg.installed:
    - pkgs:
      - x11-libs/libxkbcommon
      - dev-libs/libinput

{{sls}} - Install Enlightenment E21:
#  pkg.installed:
#    - name: '@enlightenment-core'
#    - version: 9999
  cmd.run:
    - name: 'emerge --color n --nospinner --autounmask-write y 
             --autounmask-continue y @enlightenment-core-9999 {{headtail}}'
    - onlyif: "! test -f /usr/bin/enlightenment"
    - require:
      - {{sls}} - Add 'enlightenment-live' overlay with Layman
      - {{sls}} - Create keywords directory for Portage
      - {{sls}} - Install dependancy packages

{{sls}} - Create ~/.xinitrc:
  file.managed:
    - name: /home/{{pillar.user}}/.xinitrc
    - contents:
      - exec dbus-launch --exit-with-session enlightenment_start
    - require:
      - {{sls}} - Install Enlightenment E21

{% endif %}  # Gentoo
