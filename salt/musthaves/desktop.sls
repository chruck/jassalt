{% from tpldir ~ "/map.jinja" import musthaves with context %}

include:
  - gentoo

{{sls}} - Must-Haves for Desktop:
  pkg.installed:
    - refresh: True
#    - install_recommends: False
    - pkgs:
      {% for pkg in musthaves.desktoplist %}
      - {{pkg}}
      {% endfor %}

{% for svc in musthaves.desktopservices %}

{{sls}} - Enable and Start {{svc}}:
  service.running:
    - name: {{svc}}
    - enable: True
    - require: {{sls}} - Must-Haves for Desktop

{% endfor %}
