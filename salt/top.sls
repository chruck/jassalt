{% set baseURL = "salt://top" %}

base:
  '*':
    - musthaves
    - bashrc
  grace:
    - saltmaster
    #- hosts
  grace,tiger:
    - match: list
    - saltedit
    - musthaves.desktop
    - musthaves.synergy
    - clemson
