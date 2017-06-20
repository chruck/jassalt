{% from tpldir ~ "/map.jinja" import vim with context %}

{{sls}} - Install Vim packages:
  pkg.installed:
    - refresh: True
    - install_recommends: False
    - pkgs:
      {% for pkg in vim.pkglist %}
      - {{pkg}}
      {% endfor %}

{% if 'RedHat' != grains['os_family'] %}

{% set vimaddonmanager = "vim-addon-manager" %}

{{sls}} - Install {{vimaddonmanager}}:
  pkg.latest:
    - name: {{vimaddonmanager}}
    - refresh: True
    - install_recommends: False

{{sls}} - Enable Vim addons:
  cmd.wait:
    - name: vim-addons install -w info jinja matchit omnicppcomplete xmledit
    - watch:
      - pkg: {{vimaddonmanager}}

{% endif %}
