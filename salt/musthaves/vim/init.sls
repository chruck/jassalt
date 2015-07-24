{% set baseURL = "salt://musthaves/vim" %}

{% set vimaddonmanager = "vim-addon-manager" %}
{% set vimdoc = "vim-doc" %}
{% set vimscripts = "vim-scripts" %}

{{baseURL}} - Install Vim packages:
  pkg.latest:
    - install_recommends: False
    - pkgs:
      - vim
      - {{vimdoc}}
      - {{vimscripts}}

{{baseURL}} - Install {{vimaddonmanager}}:
  pkg.latest:
    - name: {{vimaddonmanager}}
    - install_recommends: False

{{baseURL}} - Enable Vim addons:
  cmd.wait:
    - name: vim-addons install -w info jinja matchit omnicppcomplete xmledit
    - watch:
      - pkg: {{vimaddonmanager}}
