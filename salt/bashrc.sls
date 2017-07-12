include:
  - adduser

{{sls}} - Upload root's .bashrc.jas:
  file.managed:
    - name: /root/.bashrc.jas
    - source: salt://{{sls}}/.bashrc.jas
    - onlyif: "! test -L /root/.bashrc.jas"

{{sls}} - Upload Jas' .bashrc.jas:
  file.managed:
    - name: /home/{{pillar['user']}}/.bashrc.jas
    - source: salt://{{sls}}/.bashrc.jas
    - onlyif: "! test -L /home/{{pillar['user']}}/.bashrc.jas"
    - require:
      - "adduser - Create user '{{pillar.user}}'"
