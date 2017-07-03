# From http://docs.saltstack.com/en/latest/faq.html#what-is-the-best-way-to-restart-a-salt-daemon-using-salt :

include:
  - useflags

{% from "salt/map.jinja" import at, pkg with context %}

{{sls}} - Install salt-minion pkg:
  pkg.installed:
    - name: {{pkg.minion}}
    - refresh: True

{{sls}} - Set hash to SHA512:
  file.managed:
    - name: /etc/salt/minion.d/hash.conf
    - contents: "hash_type: sha512"
    - require:
      - {{sls}} - Install salt-minion pkg

{{sls}} - Ensure salt-minion service is running:
  service.running:
    - name: salt-minion
    - enable: True
    - require:
      - {{sls}} - Install salt-minion pkg

{#
{{sls}} - Restart salt-minion in 1 minute from now:
  cmd.wait:
    - name: echo service salt-minion restart | at now + 1 minute
    - watch:
      - {{sls}} - Install 'at' package
      - {{sls}} - Enable 'at' daemon
      - {{sls}} - Install salt-minion pkg
#}

{{sls}} - Install 'at' package:
  pkg.installed:
    - name: {{at.pkg}}
    - refresh: True

{{sls}} - Enable 'at' daemon:
  service.running:
    - name: {{at.daemon}}
    - enable: True
    - watch:
      - {{sls}} - Install 'at' package
