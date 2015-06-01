{% set baseURL = "salt://top" %}

base:
  '*':
    - musthaves
    - bashrc
    - saltminion
  grace:
    - saltmaster
    #- hosts
  grace,tiger:
    - match: list
    - saltedit
    - musthaves.desktop
    - musthaves.synergy
    - clemson
