{% if 2015 > grains['saltversioninfo'][0] %}
{%   set tpldir = 'musthaves' %}
{%   set tplfile = tpldir ~ '/git.sls' %}
{% endif %}

# Separated out to satisfy another state

{{tplfile}} - Install git package:
  pkg.latest:
    - name: git
    - refresh: True
    - install_recommends: False

{% if 'RedHat' != grains['os_family'] %}
{{tplfile}} - Install git-completion package:
  pkg.latest:
    - name: git-completion
    - refresh: True
    - install_recommends: False

{{tplfile}} - Install git-doc package:
  pkg.latest:
    - name: git-doc
    - refresh: True
    - install_recommends: False
{% endif %}
