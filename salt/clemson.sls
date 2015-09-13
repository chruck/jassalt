{% if 2015 > grains['saltversioninfo'][0] %}
{%   set tpldir = '' %}
{%   set tplfile = tpldir ~ 'clemson.sls' %}
{% endif %}

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
                

{{tplfile}} - Install packages to use with Clemson systems:
  pkg.latest:
    - refresh: True
    - install_recommends: False
    - pkgs:
      - openconnect
      - subversion
      - rdesktop

{{tplfile}} - Download Clemson binaries:
  git.latest:
    - name: https://github.com/eckardclemson/bin.git
    - target: {{jasSrcBin}}
    - user: jas
    - require:
      - pkg: git

{% for dest, src in programs %}
{{tplfile}} - Symlink {{src}} to {{dest}}:
  file.symlink:
    - name: {{dest}}
    - target: {{src}}
    - user: jas
    - group: jas
    - remote_name: jas
    - makedirs: True
{% endfor %}
