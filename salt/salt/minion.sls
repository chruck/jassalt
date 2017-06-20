# From http://docs.saltstack.com/en/latest/faq.html#what-is-the-best-way-to-restart-a-salt-daemon-using-salt :

{% from "salt/map.jinja" import saltminion, at with context %}

{{sls}} - Install salt-minion pkg:
  pkg.installed:
    - name: {{saltminion.pkg}}
    - refresh: True

{{sls}} - Set hash to SHA512:
  file.managed:
    - name: /etc/salt/minion.d/hash.conf
    - contents: "hash_type: sha512"
    - require:
      - pkg: {{sls}} - Install salt-minion pkg

{{sls}} - Ensure salt-minion service is running:
  service.running:
    - name: salt-minion
    - enable: True
    - require:
      - pkg: {{sls}} - Install salt-minion pkg

{{sls}} - Restart salt-minion in 1 minute from now:
  cmd.wait:
    - name: echo service salt-minion restart | at now + 1 minute
    - watch:
      - pkg: {{sls}} - Install 'at' package
      - pkg: {{sls}} - Enable 'at' daemon
      - pkg: {{sls}} - Install salt-minion pkg

{{sls}} - Install 'at' package:
  pkg.installed:
    - name: {{at.pkg}}
    - refresh: True

{{sls}} - Enable 'at' daemon:
  service.running:
    - name: {{at.daemon}}
    - enable: True
    - watch:
      - pkg: {{sls}} - Install 'at' package
