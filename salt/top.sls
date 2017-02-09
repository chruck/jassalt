base:
  # Only needs saltminion (alarm doesn't need 'musthaves', eg)
  '*':
    - salt
    - grub
  tiger,stack:
    - match: list
    - salt.master
    - salt.virt
    #- hosts
  grace,tiger,stack:
    - match: list
    - musthaves
    - bashrc
#- salt
#- grub
    - salt.edit
    - musthaves.desktop
    - musthaves.synergy
    - musthaves.vlc
    - clemson
    - sudoInsult
