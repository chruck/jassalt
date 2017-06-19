# Separated out to satisfy another state
{% from tpldir ~ "/map.jinja" import musthaves with context %}

{% for pkg in musthaves.gitpkgs %}
{{sls}} - Install {{pkg}} package:
  pkg.install:
    - name: {{pkg}}
    - refresh: True
    - install_recommends: False
{% endfor %}
