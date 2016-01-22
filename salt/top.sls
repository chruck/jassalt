base:
  # Only needs saltminion (alarm doesn't need 'musthaves', eg)
  '*':
    - saltminion
    - grub
  tiger:
    - saltmaster
    #- hosts
  grace,tiger:
    - match: list
    - musthaves
    - bashrc
    - saltminion
    - grub
    - saltedit
    - musthaves.desktop
    - musthaves.synergy
    - musthaves.vlc
    - clemson
