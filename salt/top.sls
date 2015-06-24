{% set baseURL = "salt://top" %}

base:
  grace:
    - saltmaster
    #- hosts
  '*':
    - musthaves
    - bashrc
    - saltminion
    - grub
  grace,tiger:
    - match: list
    - saltedit
    - musthaves.desktop
    - musthaves.synergy
    - musthaves.vlc
    - clemson
