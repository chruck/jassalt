{% from "salt/map.jinja" import jassaltDir with context %}

{#
{% set srcDir = "/usr/src" %}
{% set jassaltDir = srcDir ~ "/jassalt" %}
#}

{{sls}} - Pull down the latest jassalt salt states:
  git.latest:
    - name: {{githubURL}}/jassalt.git
    - target: {{jassaltDir}}
    - force_reset: True
    - require:
      - pkg: git
