# From http://docs.saltstack.com/en/latest/faq.html#what-is-the-best-way-to-restart-a-salt-daemon-using-salt :

{{sls}} - Install package salt-minion:
  pkg.latest:
    - name: salt-minion
    - refresh: True
    - order: last

{{sls}} - Ensure salt-minion service is running:
  service.running:
    - name: salt-minion
    - enable: True
    - require:
      - pkg: salt-minion

{{sls}} - Restart salt-minion in 1 minute from now:
  cmd.wait:
    - name: echo service salt-minion restart | at now + 1 minute
    - watch:
      - pkg: salt-minion

{{sls}} - Install 'at' package:
  pkg.latest:
    - name: at
    - refresh: True

{{sls}} - Enable 'at' daemon:
  service.running:
    - name: atd
    - enable: True
