{% from "salt/map.jinja" import jassaltDir with context %}

{% set saltRoster = "/etc/salt/roster" %}
{#
{% set jassaltDir = "/usr/src/jassalt" %}
#}

include:
  - salt.master

{{sls}} - Install salt-ssh pkg:
  pkg.latest:
    - name: salt-ssh
    - refresh: True

{{sls}} - Symlink for {{saltRoster}}:
  file.symlink:
    - name: {{saltRoster}}
    - target: {{jassaltDir}}/salt/salt/roster
    - force: True
    - require:
      - file: salt.master - Create /srv
