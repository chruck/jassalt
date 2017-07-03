# Separated out to satisfy another state
{% from tpldir ~ "/map.jinja" import musthaves with context %}

include:
  - useflags

{{sls}} - Install {{musthaves.gitpkg}} package:
  pkg.installed:
    - name: {{musthaves.gitpkg}}
    - refresh: True
    - install_recommends: False

{% if musthaves.gitpkgs is defined %}
{%   for pkg in musthaves.gitpkgs %}
{{sls}} - Install {{pkg}} package:
  pkg.installed:
    - name: {{pkg}}
    - refresh: True
    - install_recommends: False
{%   endfor %}
{% endif %}
