{% if "Gentoo" == grains.os %}

{% set gccver = "5.4.0" %}

include:
  - musthaves.desktop

{{sls}} - Set make.conf MAKEOPTS:
  file.managed:
    - name: /etc/portage/make.conf
    - contents:
      - CFLAGS="-Os -pipe -march=native"
      - CXXFLAGS="${CFLAGS}"
      - MAKEOPTS="-j{{grains.num_cpus + 1}}"
      - USE="X alsa bluetooth btrfs cups dbus hardened icu networkmanager pulseaudio sound symlink xcomposite xinerama xrandr -mercurial -modemmanager -ppp"
#      - PYTHON_TARGETS="python3_6 -python3_4 -python3_5"
    - order: 1

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

{{sls}} - Unmask gcc-{{gccver}} for Chromium:
  file.managed:
    - name: /etc/portage/package.unmask/sys-devel/gcc
    - contents:
      - =sys-devel/gcc-{{gccver}}

{{sls}} - Install gcc-{{gccver}}:
  pkg.installed:
    - name: sys-devel/gcc
    - version: {{gccver}}
    - require:
      - {{sls}} - Unmask gcc-{{gccver}} for Chromium

{{sls}} - Switch to gcc-{{gccver}}:
  cmd.run:
    - name: gcc-config x86_64-pc-linux-gnu-{{gccver}}
    - require:
      - {{sls}} - Install gcc-{{gccver}}

{{sls}} - Rebuild Standard C++ library for gcc-5:
  cmd.run:
    - name: revdep-rebuild --library 'libstdc++.so.6' -- --exclude gcc
    - require:
      - {{sls}} - Switch to gcc-{{gccver}}
    - onfail:
      - musthaves.desktop - Must-Haves for Desktop

{% endif %}  # Gentoo
