base:
  # Only needs saltminion (alarm doesn't need 'musthaves', eg)
  '*':
    - salt
    - grub
    - adduser
  grace,tiger,stack,iac,zetta:
    - match: list
    - musthaves
    - bashrc
    - salt.edit
    - musthaves.desktop
    - musthaves.vlc
    - clemson
    - sudoInsult
  tiger,stack,iac,zetta:
    - match: list
    - salt.master
    #- salt.virt
    - salt.ssh
  grace,tiger:
    - match: list
    - musthaves.synergy
