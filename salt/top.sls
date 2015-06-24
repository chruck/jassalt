{% set baseURL = "salt://top" %}

base:
  '*':
    - musthaves
    - bashrc
    - saltminion
    - grub
  grace:
    - saltmaster
    #- hosts
  grace,tiger:
    - match: list
    - saltedit
    - musthaves.desktop
    - musthaves.synergy
    - musthaves.vlc
    - clemson
