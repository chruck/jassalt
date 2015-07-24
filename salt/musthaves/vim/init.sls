{% from tpldir ~ "/map.jinja" import vim with context %}

{{tplfile}} - Install Vim packages:
  pkg.latest:
    - install_recommends: False
    - pkgs:
      {% for pkg in vim.pkglist %}
      - {{pkg}}
      {% endfor %}

{% if 'RedHat' != grains['os_family'] %}

{% set vimaddonmanager = "vim-addon-manager" %}

{{tplfile}} - Install {{vimaddonmanager}}:
  pkg.latest:
    - name: {{vimaddonmanager}}
    - install_recommends: False

{{tplfile}} - Enable Vim addons:
  cmd.wait:
    - name: vim-addons install -w info jinja matchit omnicppcomplete xmledit
    - watch:
      - pkg: {{vimaddonmanager}}

{% endif %}