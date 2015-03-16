Vim files for editing Saltstack files:
  git.latest:
    - name: https://github.com/saltstack/salt-vim.git
    - target: /usr/src
    - require:
      - pkg: git
