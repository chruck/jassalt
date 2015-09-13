{% if 2015 > grains['saltversioninfo'][0] %}
{%   set tpldir = 'musthaves' %}
{%   set tplfile = tpldir ~ '/vlc.sls' %}
{% endif %}

{{tplfile}} - Must-Haves for Desktop:
  pkg.latest:
    - name: vlc
    - refresh: True
    - install_recommends: False
