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
                  ] %}
                

{{sls}} - Install packages to use with Clemson systems:
  pkg.latest:
    - refresh: True
    - install_recommends: False
    - pkgs:
      - openconnect
      - subversion
      - rdesktop

{{sls}} - Download Clemson binaries:
  git.latest:
    - name: https://github.com/eckardclemson/bin.git
    - target: {{jasSrcBin}}
    - user: {{pillar['user']}}
    - require:
      - pkg: git

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
