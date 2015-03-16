Vim files for editing Saltstack files:
  git.latest:
    - name: https://github.com/saltstack/salt-vim.git
    - target: /usr/src/salt-vim
    - require:
      - pkg: git

Symlink sls filetype detection for Vim:
  file.symlink:
    - name: /etc/vim/ftdetect/sls.vim
    - target: /usr/src/salt-vim/ftdetect/sls.vim
    - makedirs: True

Symlink sls filetype plugin for Vim:
  file.symlink:
    - name: /etc/vim/ftplugin/sls.vim
    - target: /usr/src/salt-vim/ftplugin/sls.vim
    - makedirs: True

Symlink sls syntax for Vim:
  file.symlink:
    - name: /etc/vim/syntax/sls.vim
    - target: /usr/src/salt-vim/syntax/sls.vim
    - makedirs: True
