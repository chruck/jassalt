# From http://docs.saltstack.com/en/latest/faq.html#what-is-the-best-way-to-restart-a-salt-daemon-using-salt :

{% if 2015 > grains['saltversioninfo'][0] %}
{%   set tpldir = 'musthaves' %}
{%   set tplfile = tpldir ~ '/salt-minion.sls' %}
{% endif %}

{{tplfile}} - Install package salt-minion:
  pkg.latest:
    - name: salt-minion
    - refresh: True
    - order: last

{{tplfile}} - Ensure salt-minion service is running:
  service.running:
    - name: salt-minion
    - enable: True
    - require:
      - pkg: salt-minion

{{tplfile}} - Restart salt-minion in 1 minute from now:
  cmd.wait:
    - name: echo service salt-minion restart | at now + 1 minute
    - watch:
      - pkg: salt-minion

{{tplfile}} - Install 'at' package:
  pkg.latest:
    - name: at
    - refresh: True

{{tplfile}} - Enable 'at' daemon:
  service.running:
    - name: atd
    - enable: True
