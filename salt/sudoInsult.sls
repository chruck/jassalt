{{sls}} - Set sudo to insult you when you put in a bad password:
  file.managed:
    - name: /etc/sudoers.d/insults
    - contents: Defaults insults
