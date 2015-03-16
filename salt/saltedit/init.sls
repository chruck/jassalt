Vim files for editing Saltstack files:
  git.latest:
    - name: https://github.com/saltstack/salt-vim.git
    - target: /usr/src/salt-vim
    - require:
      - pkg: git
