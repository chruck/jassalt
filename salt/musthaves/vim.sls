{% set vimaddonmanager = "vim-addon-manager" %}
{% set vimdoc = "vim-doc" %}
{% set vimscripts = "vim-scripts" %}

Install Vim packages:
  pkg.installed:
    - install_recommends: False
    - pkgs:
      - vim
      - {{ vimdoc }}
      - {{ vimscripts }}

{{ vimaddonmanager }}:
  pkg.installed:
    - install_recommends: False

Install Vim addons:
  cmd.wait:
    - name: vim-addons install -w info jinja matchit omnicppcomplete xmledit
    - watch:
      - pkg: {{ vimaddonmanager }}
