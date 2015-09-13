{{sls}} - Upload root's .bashrc.jas:
  file.managed:
    - name: /root/.bashrc.jas
    - source: {{sls}}/.bashrc.jas

{{sls}} - Upload Jas' .bashrc.jas:
  file.managed:
    - name: /home/jas/.bashrc.jas
    - source: {{sls}}/.bashrc.jas
