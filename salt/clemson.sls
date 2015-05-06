{% set baseURL = "salt://clemson" %}
{% set jasHome = "/home/jas/" %}
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
                

{{baseURL}} - Install packages to use with Clemson systems:
  pkg.installed:
    - install_recommends: False
    - pkgs:
      - openconnect
      - subversion
      - rdesktop

{{baseURL}} - Download Clemson binaries:
  git.latest:
    - name: https://github.com/eckardclemson/bin.git
    - target: {{jasSrcBin}}
    - user: jas
    - group: jas
    - require:
      - pkg: git

{% for dest, src in programs %}
{{baseURL}} - Symlink {{src}} to {{dest}}:
  file.symlink:
    - name: {{dest}}
    - target: {{src}}
    - user: jas
    - group: jas
    - remote_name: jas
    - makedirs: True
{% endfor %}
