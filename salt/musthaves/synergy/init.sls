{% set baseURL = "salt://musthaves/synergy/" %}

{{baseURL}} - Install Synergy:
  pkg.installed:
    - name: synergy
    - install_recommends: False

{{baseURL}} - Add Synergy config file:
  file.managed:
    - name: /etc/synergy.conf
    - source: {{baseURL}}/synergy.conf.tmpl
    - template: jinja
    - defaults:
        synergyServer: "tiger"
        synergyClient: "grace"
