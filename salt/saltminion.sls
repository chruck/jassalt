{% if 2015 > grains['saltversioninfo'][0] %}
{%   set tpldir = '' %}
{%   set tplfile = tpldir ~ '/saltminion.sls' %}
{% endif %}

{% from "map.jinja" import saltminion with context %}

{{sls}} - Value of saltminion.pkg:
  cmd.run:
    - name: echo {{saltminion.pkg}}

{{sls}} - Install salt-minion pkg:
  pkg.latest:
    - name: {{saltminion.pkg}}
    - refresh: True
