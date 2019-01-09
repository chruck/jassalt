{% if "Ubuntu" == grains['os'] %}

{%     set latestUrl = "http://repo.saltstack.com/apt/ubuntu/" ~
                       grains["lsb_distrib_release"] ~ "/" ~
                       grains["osarch"] ~ "/latest" %}

{{sls}} - Install SaltStack repository:
  pkgrepo.managed:
    - humanname: "SaltStack repo"
    - name: "deb {{latestUrl}} {{grains['lsb_distrib_codename']}} main"
    - file: /etc/apt/sources.list.d/saltstack.list
    - key_url: {{latestUrl}}/SALTSTACK-GPG-KEY.pub 
    - gpgcheck: 1

{% endif %}
