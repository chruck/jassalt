{% if "Gentoo" == grains.os %}

#{{sls}} - Set global USE flags:
#{{sls}} - Set global MAKEOPTS and USE:
{{sls}} - Set make.conf MAKEOPTS:
  file.managed:
    - name: /etc/portage/make.conf
    - contents:
      - MAKEOPTS="-j{{grains.num_cpus + 1}}"
#      - USE="X dbus -modemmanager -ppp"
#      - PYTHON_TARGETS="python3_6 -python3_4 -python3_5"
    - order: 1

{%      for flag in [ 'X', 'dbus', ] %}
{{sls}} - Set make.conf USE flag '{{flag}}':
  cmd.run:
    - name: euse -E {{flag}}
{%      endfor %}

{%      for flag in [ 'modemmanager', 'ppp', 'mercurial', ] %}
{{sls}} - Unset make.conf USE flag '{{flag}}':
  cmd.run:
    - name: euse -D {{flag}}
{%      endfor %}

#{{sls}} - Set global USE flags:
#  portage_config.flags:
#    - name: @world
#    - use:
#      - X
#      - dbus
#      - -modemmanager
#      - -ppp

{{sls}} - Set USE flags for libpng:
  portage_config.flags:
    - name: libpng
    - use:
      - apng

{{sls}} - Set license flag for adobe-flash:
  portage_config.flags:
    - name: ">=www-plugins/adobe-flash-26.0.0.131"
    - license:
      - AdobeFlash-11.x

{% endif %}  # Gentoo
