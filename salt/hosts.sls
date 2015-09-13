{% if 2015 > grains['saltversioninfo'][0] %}
{%   set tpldir = '' %}
{%   set tplfile = tpldir ~ '/hosts.sls' %}
{% endif %}

{{tplfile}} - Add tiger to /etc/hosts:
  file.append:
    - name: /etc/hosts
    - text:
      - "172.16.16.100 tiger"

{{tplfile}} - Add grace to /etc/hosts:
  file.append:
    - name: /etc/hosts
    - text:
      - "172.16.16.107 grace salt"

{{tplfile}} - Add alarm to /etc/hosts:
  file.append:
    - name: /etc/hosts
    - text:
      - "172.16.16.131 alarm"
