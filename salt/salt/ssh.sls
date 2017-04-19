{% set saltDir = "/srv/salt" %}
{% set saltRoster = saltDir ~ "/roster" %}
{% set jassaltDir = srcDir ~ "/jassalt" %}

include:
  - salt.master

{{sls}} - Install salt-ssh pkg:
  pkg.latest:
    - name: salt-ssh
    - refresh: True

{{sls}} - Symlink for {{saltRoster}}:
  file.symlink:
    - name: {{saltRoster}}
    - target: {{jassaltDir}}/salt/roster
    - require:
      - file: salt.master - Create {{srvDir}}
