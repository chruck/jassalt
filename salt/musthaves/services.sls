{% from tpldir ~ "/map.jinja" import musthaves with context %}

{% for svc in musthaves.services %}

{{sls}} - Enable and Start {{svc}}:
  service.running:
    - name: {{svc}}
    - enable: True
#    - require:
#      - musthaves/desktop.sls - Must-Haves for Desktop
#      - musthaves/init.sls - Must-Haves

{% endfor %}
