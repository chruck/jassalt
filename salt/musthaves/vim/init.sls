{% from tpldir ~ "/map.jinja" import vim with context %}

include:
  - useflags

{{sls}} - Install Vim packages:
  pkg.installed:
    - refresh: True
    - install_recommends: False
    - pkgs:
      {% for pkg in vim.pkglist %}
      - {{pkg}}
      {% endfor %}

{% if vim.vimaddonmanager is defined %}

{{sls}} - Install {{vim.vimaddonmanager}}:
  pkg.installed:
    - name: {{vim.vimaddonmanager}}
    - refresh: True
    - install_recommends: False

{{sls}} - Enable Vim addons:
  cmd.wait:
    - name: vim-addons install -w info jinja matchit omnicppcomplete xmledit
    - watch:
      - pkg: {{vim.vimaddonmanager}}

{% endif %}
