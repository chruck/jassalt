{% if 2015 > grains['saltversioninfo'][0] %}
{%   set tpldir = 'musthaves/synergy' %}
{%   set tplfile = tpldir ~ '/init.sls' %}
{% endif %}

{% set synergyServer = "tiger" %}
{% set synergyServerIP = "172.16.16.100" %}
{% set synergyClient = "grace" %}
{% set synergyClientIP = "172.16.16.107" %}

{% if grains["host"] == synergyServer %}
  {% set daemon = "Server" %}
  {% set command = "sudo -u jas sh -c 'pkill synergys; DISPLAY=:0.0 synergys'" %}
{% elif grains["host"] == synergyClient %}
  {% set daemon = "Client" %}
  {% set command = "sudo -u jas sh -c 'pkill synergyc; DISPLAY=:0.0 synergyc " ~ synergyServer ~ "'"%}
{% endif %}

{{sls}} - Install Synergy:
  pkg.latest:
    - name: synergy
    - refresh: True
    - install_recommends: False

{{sls}} - Add Synergy config file:
  file.managed:
    - name: /etc/synergy.conf
    - source: {{sls}}/synergy.conf.tmpl
    - template: jinja
    - defaults:
        synergyServer: {{synergyServer}}
        synergyServerIP: {{synergyServerIP}}
        synergyClient: {{synergyClient}}
        synergyClientIP: {{synergyClientIP}}

{{sls}} - Start Synergy {{daemon}}:
  cmd.wait:
    - name: {{command}}
    - watch:
      - file: {{sls}} - Add Synergy config file
