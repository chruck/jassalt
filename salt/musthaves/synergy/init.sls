{% set baseURL = "salt://musthaves/synergy/" %}

{% set synergyServer = "tiger" %}
{% set synergyClient = "grace" %}

{% if grains["host"] == synergyServer %}
  {% set daemon = "Server" %}
  {% set command = "synergys" %}
{% elif grains["host"] == synergyClient %}
  {% set daemon = "Client" %}
  {% set command = "synergyc " ~ synergyServer %}
{% endif %}

{{baseURL}} - Install Synergy:
  pkg.installed:
    - name: synergy
    - install_recommends: False

{{baseURL}} - Add Synergy config file:
  file.managed:
    - name: /etc/synergy.conf
    - source: {{baseURL}}/synergy.conf.tmpl
    - template: jinja
#    - defaults:
#        synergyServer: "tiger"
#        synergyClient: "grace"

{{baseURL}} - Start Synergy {{daemon}}:
  cmd.run:
    - name: {{command}}
