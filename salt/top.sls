{% set baseURL = "salt://top" %}

base:
  '*':
    - musthaves
  grace:
    - saltmaster
    #- hosts
  grace,tiger:
    - match: list
    - saltedit
    - musthaves.desktop
    - musthaves.synergy
    - clemson
