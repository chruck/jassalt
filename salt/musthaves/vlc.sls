{% set baseURL = "salt://musthaves/vlc" %}

{{baseURL}} - Must-Haves for Desktop:
  pkg.latest:
    - name: vlc
    - install_recommends: False
