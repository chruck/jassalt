{% from tpldir ~ "/map.jinja" import musthaves with context %}

include:
  - useflags

{{sls}} - Must-Haves for Desktop, vlc:
  pkg.installed:
    - name: {{musthaves.vlc}}
    - refresh: True
#    - install_recommends: False
#    - uses: X
