{% from "map.jinja" import saltminion with context %}

{{sls}} - Install salt-minion pkg:
  pkg.latest:
    - name: {{saltminion.bin}}
    - refresh: True

{{sls}} - Set hash to SHA512:
  file.managed:
    - name: /etc/salt/minion.d/hash.conf
    - contents: "hash_type: sha512"
    - require:
      - pkg: {{sls}} - Install salt-minion pkg
