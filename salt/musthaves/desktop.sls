{% from tpldir ~ "/map.jinja" import musthaves with context %}
{% from tpldir ~ "/vars.jinja" import
        musthaves4Desktop,
        with context %}

include:
  - gentoo
  - .googlechrome

{{musthaves4Desktop}}:
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
    - require:
      - {{musthaves4Desktop}}
{% endfor %}
