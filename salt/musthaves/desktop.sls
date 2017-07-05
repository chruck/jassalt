{% from tpldir ~ "/map.jinja" import musthaves with context %}

include:
  - useflags
  - acceptlicense

{{sls}} - Must-Haves for Desktop:
  pkg.installed:
    - refresh: True
#    - install_recommends: False
    - pkgs:
      {% for pkg in musthaves.desktoplist %}
      - {{pkg}}
      {% endfor %}
