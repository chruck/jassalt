{% from "salt/map.jinja" import githubURL, jassaltDir with context %}
{% from "musthaves/map.jinja" import musthaves with context %}

{#
{% set srcDir = "/usr/src" %}
{% set jassaltDir = srcDir ~ "/jassalt" %}
#}

{{sls}} - Pull down the latest jassalt salt states:
  git.latest:
    - name: {{githubURL}}/jassalt.git
    - target: {{jassaltDir}}
    - force_reset: True
    - require:
      - musthaves.git - Install {{musthaves.gitpkgs[0]}} package
