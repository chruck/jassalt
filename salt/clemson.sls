{% from "musthaves/map.jinja" import musthaves with context %}

{% set jasHome = "/home/" ~ pillar['user'] ~ "/" %}
{% set jasSrcBin = jasHome ~ "/src/bin/" %}
{% set jasBin = jasHome ~ "/bin/" %}
{% set programs = [
                   (jasBin ~ "cuvpn",           jasSrcBin ~ "cuvpn"),
                   (jasBin ~ "spectrum",        jasSrcBin ~ "spectrum"),
                   (jasBin ~ "rdesktop.vdi",    jasSrcBin ~ "rdesktop.vdi"),
                   (jasBin ~ "vdi.rdesktop",    jasBin ~ "rdesktop.vdi"),
                   (jasBin ~ "vmware-view.vdi", jasSrcBin ~ "vmware-view.vdi"),
                   (jasBin ~ "vdi.vmware-view", jasBin ~ "vmware-view.vdi"),
                   (jasBin ~ "vpnc-script",     jasSrcBin ~ "vpnc-script"),
                  ] %}
{% set pkgs = salt['grains.filter_by']({
        "default": [
                'icedtea',
                'openconnect',
                'rdesktop',
                'subversion',
                'vpnc',
        ],
        "Gentoo": [
                'dev-java/icedtea-web',
                'dev-vcs/subversion',
                'net-misc/rdesktop',
                'net-vpn/openconnect',
                'net-vpn/vpnc',
        ],
}, default='default'
) %}

include:
  - gentoo
  - musthaves.git

{{sls}} - Install packages to use with Clemson systems:
  pkg.installed:
    - refresh: True
    - install_recommends: False
    - pkgs:
      {% for pkg in pkgs %}
      - {{pkg}}
      {% endfor %}

{{sls}} - Download Clemson binaries:
  git.latest:
    - name: https://github.com/eckardclemson/bin.git
    - target: {{jasSrcBin}}
    - user: {{pillar['user']}}
    - require:
      - musthaves.git - Install {{musthaves.gitpkg}} package

{% for dest, src in programs %}
{{sls}} - Symlink {{src}} to {{dest}}:
  file.symlink:
    - name: {{dest}}
    - target: {{src}}
    - user: {{pillar['user']}}
    - group: {{pillar['user']}}
    - remote_name: {{pillar['user']}}
    - makedirs: True
{% endfor %}
