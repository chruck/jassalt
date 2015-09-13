{% if 2015 > grains['saltversioninfo'][0] %}
{%   set tpldir = '' %}
{%   set tplfile = tpldir ~ '/saltminion.sls' %}
{% endif %}

{{tplfile}} - Install salt-minion pkg:
  pkg.latest:
    - name: salt-minion
    - refresh: True
