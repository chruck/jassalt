{% if "Gentoo" == grains.os %}

#{{sls}} - Set global USE flags:
#{{sls}} - Set global MAKEOPTS and USE:
{{sls}} - Set make.conf MAKEOPTS:
  file.managed:
    - name: /etc/portage/make.conf
    - contents:
      - CFLAGS="-Os -pipe -march=native -std=c11"
      - CXXFLAGS="-Os -pipe -march=native"
      - MAKEOPTS="-j{{grains.num_cpus + 1}}"
      - USE="X cups dbus icu -mercurial -modemmanager -ppp"
#      - PYTHON_TARGETS="python3_6 -python3_4 -python3_5"
    - order: 1

#{%      for flag in [ 'X', 'cups', 'dbus', 'icu', 'nvidia', ] %}
#{{sls}} - Set make.conf USE flag '{{flag}}':
#  cmd.run:
#    - name: euse -E {{flag}}
#{%      endfor %}

#{%      for flag in [ 'mercurial', 'modemmanager', 'ppp', ] %}
#{{sls}} - Unset make.conf USE flag '{{flag}}':
#  cmd.run:
#    - name: euse -D {{flag}}
#{%      endfor %}

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

{{sls}} - Set license flag for google-chrome:
  portage_config.flags:
    - name: ">=www-client/google-chrome-59.0.3071.115"
    - license:
      - google-chrome

{% endif %}  # Gentoo
