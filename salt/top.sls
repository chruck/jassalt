{% set baseURL = "salt://top" %}

base:
  '*':
    - musthaves
  grace:
    - saltmaster
  grace,tiger:
    - match: list
    - saltedit
    - musthaves.desktop
    - clemson
