{% if "Gentoo" == grains.os %}

#{{sls}} - Set global USE flags:
#{{sls}} - Set global MAKEOPTS and USE:
{{sls}} - Set make.conf MAKEOPTS:
  file.managed:
    - name: /etc/portage/make.conf
    - contents:
      - CFLAGS="-Os -pipe -march=native"
      - CXXFLAGS="${CFLAGS}"
      - MAKEOPTS="-j{{grains.num_cpus + 1}}"
      - USE="X cups dbus hardened icu -mercurial -modemmanager -ppp"
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

{{sls}} - Set USE flags for firefox:
  portage_config.flags:
    - name: firefox
    - use:
      - bindist

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

{{sls}} - Unmask gcc-5.4.0 for Chromium:
  file.managed:
    - name: /etc/portage/package.unmask/chromium
    - contents:
      - =sys-devel/gcc-5.4.0

{{sls}} - Install gcc-5.4.0:
  pkg.installed:
    - name: sys-devel/gcc
    - version: 5.4.0
    - require: {{sls}} - Unmask gcc-5.4.0 for Chromium

{{sls}} - Switch to gcc-5.4.0:
  cmd.run:
    - name: gcc-config x86_64-pc-linux-gnu-5.4.0
    - require: {{sls}} - Install gcc-5.4.0

{% endif %}  # Gentoo
