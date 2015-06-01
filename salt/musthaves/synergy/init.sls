{% set baseURL = "salt://musthaves/synergy/" %}

{% set synergyServer = "tiger" %}
{% set synergyServerIP = "172.16.16.121" %}
{% set synergyClient = "grace" %}
{% set synergyClientIP = "172.16.16.117" %}

{% if grains["host"] == synergyServer %}
  {% set daemon = "Server" %}
  {% set command = "sudo -u jas sh -c 'pkill synergys; DISPLAY=:0.0 synergys'" %}
{% elif grains["host"] == synergyClient %}
  {% set daemon = "Client" %}
  {% set command = "sudo -u jas sh -c 'pkill synergyc; DISPLAY=:0.0 synergyc " ~ synergyServer ~ "'"%}
{% endif %}

{{baseURL}} - Install Synergy:
  pkg.latest:
    - name: synergy
    - install_recommends: False

{{baseURL}} - Add Synergy config file:
  file.managed:
    - name: /etc/synergy.conf
    - source: {{baseURL}}/synergy.conf.tmpl
    - template: jinja
    - defaults:
        synergyServer: {{synergyServer}}
        synergyServerIP: {{synergyServerIP}}
        synergyClient: {{synergyClient}}
        synergyClientIP: {{synergyClientIP}}

{{baseURL}} - Start Synergy {{daemon}}:
  cmd.run:
    - name: {{command}}
