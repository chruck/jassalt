{% set latestUrl = "http://repo.saltstack.com/apt/ubuntu/16.04/" ~ grains['osarch'] ~ "latest" %}

{{sls}} - Install SaltStack repository:
  pkgrepo.managed:
    - humanname: "SaltStack repo"
    - name: "deb {{latestUrl}} xenial main"
    - file: /etc/apt/sources.list.d/saltstack.list
    - key_url: {{latestUrl}}/SALTSTACK-GPG-KEY.pub 
    - gpgcheck: 1
