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
# "default" below is using Debian as basis
{% set pkgs = salt['grains.filter_by']({
        "default": [
                'icedtea-plugin',
                'openconnect',
                'rdesktop',
                'subversion',
                'vpnc',
        ],
        "Gentoo": [
                'dev-java/icedtea',
                'dev-java/icedtea-web',
                'dev-vcs/subversion',
                'net-misc/rdesktop',
                'net-vpn/openconnect',
                'net-vpn/vpnc',
        ],
}, default='default'
) %}
# "default" below is using Gentoo as basis
{% set javaSecFile = salt['grains.filter_by']({
        "default": '/etc/java-config-2/current-system-vm/lib/security/java.security',
        "Debian": '/etc/java-8-openjdk/security/java.security',
        "RedHat": '/etc/alternatives/jre/lib/security/java.security',
        "Gentoo": '/etc/java-config-2/current-system-vm/jre/lib/security/java.security',
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

{{sls}} - Install Spectrum JNLP file:
  file.managed:
    - name: {{jasBin}}/spectrum.jnlp
    - source: salt://spectrum.jnlp

{{sls}} - Allow MD5-signed jars (for Spectrum):
  file.replace:
    - name: {{javaSecFile}}
    - onlyif: test -f {{javaSecFile}}
    - pattern: jdk.jar.disabledAlgorithms=MD2, MD5, RSA keySize < 1024
    - repl: jdk.jar.disabledAlgorithms=MD2, RSA keySize < 1024
