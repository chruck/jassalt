{% set baseURL = "salt://saltmaster" %}

include:
  - musthaves

{{baseURL}} - Pull down the latest jassalt salt states:
  git.latest:
    - name: https://github.com/chruck/jassalt.git
    - target: /srv/jassalt
    - require:
      - pkg: git
    - require_in:
      - pkg: salt://musthaves - Must-Haves

{{baseURL}} - Symlink for /srv/salt:
  file.symlink:
    - name: /srv/salt
    - target: /srv/jassalt/salt

{{baseURL}} - Symlink for /srv/pillar:
  file.symlink:
    - name: /srv/pillar
    - target: /srv/jassalt/pillar
