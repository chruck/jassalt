{% from "salt/map.jinja" import githubURL, jassaltDir with context %}
{% from "musthaves/map.jinja" import musthaves with context %}

include:
  - musthaves.git

{{sls}} - Pull down the latest jassalt salt states:
  git.latest:
    - name: {{githubURL}}/jassalt.git
    - target: {{jassaltDir}}
    - force_reset: True
    - require:
      - musthaves.git - Install {{musthaves.gitpkg}} package
