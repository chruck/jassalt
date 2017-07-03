{% if "Gentoo" == grains.os %}

{{sls}} - Set global USE flags:
  file.managed:
    - name: /etc/portage/make.conf
    - contents:
      - MAKEOPTS="-j{{grains.num_cpus + 1}}"
      - USE="X dbus -modemmanager -ppp"

{% endif %}
