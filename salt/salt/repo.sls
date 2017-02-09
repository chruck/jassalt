{{sls}} - Install SaltStack repository:
  pkgrepo.managed:
    - humanname: "SaltStack repo"
    - name: "deb http://repo.saltstack.com/apt/ubuntu/{{grains['osrelease']}}/{{grains['osarch']}}/latest {{grains['oscodename']}} main"
    - file: /etc/apt/sources.list.d/saltstack.list
    - key_url: https://repo.saltstack.com/apt/ubuntu/{{grains['osrelease']}}/{{grains['osarch']}}/latest/SALTSTACK-GPG-KEY.pub 
    - gpgcheck: 1
