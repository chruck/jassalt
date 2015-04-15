Pull down the latest jassalt salt states:
  git.latest:
    - name: https://github.com/chruck/jassalt.git
    - target: /srv/jassalt
    - require:
      - pkg: git
    - require_in:
      - sls: musthaves
