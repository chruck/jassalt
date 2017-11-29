{% from "musthaves/map.jinja" import musthaves with context %}

{% set jasHome = "/home/" ~ pillar['user'] ~ "/" %}
{% set jasSrc = jasHome ~ "/src/" %}
{% set jasBin = jasHome ~ "/bin/" %}
{% set programs = [
                   (jasBin ~ "ghost-text-server.tcl",
                    jasSrc ~ "ghost-text-server/ghost-text-server.tcl"
                   ),
                  ] %}

include:
  - gentoo
  - .git

{{sls}} - Download GhostText Vim repo:
  git.latest:
    - name: https://github.com/falstro/ghost-text-vim.git
    - target: {{jasSrc}}
    - user: {{pillar['user']}}
    - require:
      - musthaves.git - Install {{musthaves.gitpkg}} package

{% for dest, src in programs %}
{{sls}} - Symlink {{src}} to {{dest}}:
  file.symlink:
    - name: {{dest}}
    - target: {{src}}
    - user: {{pillar['user']}}
    - group: {{pillar['user']}}
    - remote_name: {{pillar['user']}}
    - makedirs: True
{% endfor %}
