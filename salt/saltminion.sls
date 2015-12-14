{% if 2015 > grains['saltversioninfo'][0] %}
{%   set tpldir = '' %}
{%   set tplfile = tpldir ~ '/saltminion.sls' %}
{% endif %}

{% from tpldir ~ "/map.jinja" import saltminion with context %}

{{sls}} - Install salt-minion pkg:
  pkg.latest:
    - name: {{saltminion.pkg}}
    - refresh: True
