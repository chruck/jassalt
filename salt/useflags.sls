{% if "Gentoo" == grains.os %}

#{{sls}} - Set global USE flags:
{{sls}} - Set global MAKEOPTS:
  file.managed:
    - name: /etc/portage/make.conf
    - contents:
      - MAKEOPTS="-j{{grains.num_cpus + 1}}"
#      - USE="X dbus -modemmanager -ppp"
    - order: 1

{% endif %}

{{sls}} - Set global USE flags:
  portage_config.flags:
    - use:
      - X
      - apng
      - dbus
      - -modemmanager
      - -ppp
    - license:
      - ">=www-plugins/adobe-flash-26.0.0.131 AdobeFlash-11.x"
