include:
  - musthaves

{{sls}} - Configure opensshd:
  file.append:
    - name: /etc/ssh/sshd_config
    - content:
      - X11Forwarding yes
    - require_in:
      - musthaves - Must-Haves

{{sls}} - Enable and start opensshd service:
  service.running:
    - name: opensshd
    - enable: True
    - watch:
      - {{sls}} - Configure opensshd
