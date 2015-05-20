{% set baseURL = "salt://bashrc" %}

{{baseURL}} - Upload root's .bashrc.jas:
  file.managed:
    - name: /root/.bashrc.jas
    - source: {{baseURL}}/.bashrc.jas

{{baseURL}} - Upload Jas' .bashrc.jas:
  file.managed:
    - name: /home/jas/.bashrc.jas
    - source: {{baseURL}}/.bashrc.jas
