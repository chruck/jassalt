{% set baseURL = "salt://saltmaster" %}
{% set githubURL = "https://github.com/chruck" %}
{% set srcDir = "/usr/src/" %}
{% set jassaltDir = srcDir ~ "/jassalt" %}
{% set bashrcDir = srcDir ~ "/dot.bashrc.jas" %}

include:
  - musthaves
  - bashrc

{{baseURL}} - Pull down the latest jassalt salt states:
  git.latest:
    - name: {{githubURL}}/jassalt.git
    - target: {{jassaltDir}}
    - require:
      - pkg: git
    - require_in:
      - pkg: salt://musthaves - Must-Haves

{{baseURL}} - Symlink for /srv/salt:
  file.symlink:
    - name: /srv/salt
    - target: {{jassaltDir}}/salt

{{baseURL}} - Symlink for /srv/pillar:
  file.symlink:
    - name: /srv/pillar
    - target: {{jassaltDir}}/pillar

{{baseURL}} - Pull down the latest .bashrc.jas:
  git.latest:
    - name: {{githubURL}}/dot.bashrc.jas.git
    - target: {{bashrcDir}}
    - require:
      - pkg: git
    - require_in:
      - pkg: "salt://musthaves - Must-Haves"

{{baseURL}} - Symlink for /srv/salt/.bashrc.jas:
  file.symlink:
    - name: /srv/salt/bashrc/.bashrc.jas
    - target: {{bashrcDir}}/.bashrc.jas
    - require_in:
      - file: "salt://bashrc - Upload root's .bashrc.jas"
    #- require_in:
      - file: "salt://bashrc - Upload Jas' .bashrc.jas"

{{baseURL}} - Pull down the latest dnsmasq formula:
  git.latest:
    - name: https://github.com/saltstack-formulas/dnsmasq-formula.git
    - target: /srv/salt/dnsmasq-formula
    - require:
      - pkg: git
      - file: "{{baseURL}} - Symlink for /srv/salt"
    - require_in:
      - pkg: "salt://musthaves - Must-Haves"
