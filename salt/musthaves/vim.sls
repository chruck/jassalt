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

Checkout latest Salt Vim syntax:
  git.latest:
    - name: https://github.com/saltstack/salt-vim.git
    - target: /usr/src/salt-vim

Symlink salt-vim ftdetect file:
  file.symlink:
    - name: /etc/vim/ftdetect/sls.vim
    - target: /usr/src/salt-vim/ftdetect/sls.vim

Symlink salt-vim ftplugin file:
  file.symlink:
    - name: /etc/vim/ftplugin/sls.vim
    - target: /usr/src/salt-vim/ftplugin/sls.vim

Symlink salt-vim syntax file:
  file.symlink:
    - name: /etc/vim/syntax/sls.vim
    - target: /usr/src/salt-vim/syntax/sls.vim
