{% set baseURL = "salt://bashrc" %}

{{baseURL}} - Upload .bashrc.jas:
  file.managed:
    - name: /root/.bashrc.jas
    - source: {{baseURL}}/.bashrc.jas
