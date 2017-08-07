{% if "Gentoo" == grains.os %}

{% set gccver = "5.4.0" %}
{% set targetgcc = "x86_64-pc-linux-gnu-" ~ gccver %}

{% from "musthaves/vars.jinja" import
        musthavesDesktop,
        musthaves4Desktop,
        with context %}

include:
  - {{musthavesDesktop}}

{{sls}} - Set make.conf MAKEOPTS:
  file.managed:
    - name: /etc/portage/make.conf
    - source: salt://gentoo/make.conf
    - template: jinja
    - defaults:
        numThreads: {{grains.num_cpus + 1}}
    - order: 1

{{sls}} - Set USE flags for libpng:
  portage_config.flags:
    - name: libpng
    - use:
      - apng
    - require_in:
      - {{musthaves4Desktop}}

{{sls}} - Set USE flags for firefox:
  portage_config.flags:
    - name: firefox
    - use:
      - bindist

{{sls}} - Set USE flags for libxcb:
  portage_config.flags:
    - name: libxcb
    - use:
      - xkb

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
    - require_in:
      - {{musthaves4Desktop}}

{{sls}} - Unmask gcc-{{gccver}} for Chromium:
  file.managed:
    - name: /etc/portage/package.unmask/sys-devel/gcc
    - makedirs: True
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
    - name: gcc-config --nocolor {{targetgcc}}
#    - name: "gcc-config --nocolor $(gcc-config -l --nocolor |grep gnu-5 |head -n1 | tr -d '][' |cut -d\  -f2)"
    - onlyif: 'test {{targetgcc}} != $(gcc-config -c)'
    - require:
      - {{sls}} - Install gcc-{{gccver}}

{{sls}} - Rebuild Standard C++ library for gcc-5:
  cmd.run:
    - name: revdep-rebuild --library 'libstdc++.so.6' -- --exclude gcc
    - require:
      - {{sls}} - Switch to gcc-{{gccver}}
    - onfail:
      - {{musthaves4Desktop}}

{% endif %}  # Gentoo
