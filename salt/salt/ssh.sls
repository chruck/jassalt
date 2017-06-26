{% from "salt/map.jinja" import jassaltDir, pkg with context %}

{% set saltRoster = "/etc/salt/roster" %}
{#
{% set jassaltDir = "/usr/src/jassalt" %}
#}

include:
  - salt.master

{{sls}} - Install salt-ssh pkg:
  pkg.latest:
    - name: {{pkg.ssh}}
    - refresh: True

{{sls}} - Symlink for {{saltRoster}}:
  file.symlink:
    - name: {{saltRoster}}
    - target: {{jassaltDir}}/salt/salt/roster
    - force: True
    - require:
      - file: salt.master - Create /srv
