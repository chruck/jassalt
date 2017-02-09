base:
  # Only needs saltminion (alarm doesn't need 'musthaves', eg)
  '*':
    - saltminion
    - grub
  tiger,stack:
    - match: list
    - saltmaster
    - saltvirt
    #- hosts
  grace,tiger,stack:
    - match: list
    - musthaves
    - bashrc
#- saltminion
#- grub
    - salt.edit
    - musthaves.desktop
    - musthaves.synergy
    - musthaves.vlc
    - clemson
    - sudoInsult
