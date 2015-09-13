{% if 2015 > grains['saltversioninfo'][0] %}
{%   set tpldir = '' %}
{%   set tplfile = tpldir ~ '/saltedit.sls' %}
{% endif %}

{% set srcDir = "/usr/src/salt-vim/" %}
{% set etcVim = "/etc/vim/" %}

{{tplfile}} - Vim files for editing Saltstack files:
  git.latest:
    - name: https://github.com/saltstack/salt-vim.git
    - target: {{srcDir}}
    - require:
      - pkg: git

{{tplfile}} - Symlink sls filetype detection for Vim:
  file.symlink:
    - name: {{etcVim}}/ftdetect/sls.vim
    - target: {{srcDir}}/ftdetect/sls.vim
    - makedirs: True

{{tplfile}} - Symlink sls filetype plugin for Vim:
  file.symlink:
    - name: {{etcVim}}/ftplugin/sls.vim
    - target: {{srcDir}}/ftplugin/sls.vim
    - makedirs: True

{{tplfile}} - Symlink sls syntax for Vim:
  file.symlink:
    - name: {{etcVim}}/syntax/sls.vim
    - target: {{srcDir}}/syntax/sls.vim
    - makedirs: True
