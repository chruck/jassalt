base:
  # Only needs saltminion (alarm doesn't need 'musthaves', eg)
  '*':
    - salt
    - grub
  tiger,stack,iac:
    - match: list
    - salt.master
    - salt.virt
    - salt.ssh
    #- hosts
  grace,tiger,stack,iac:
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
