{{sls}} - Remove 'quiet':
  file.replace:
    - name: /etc/default/grub
    - pattern: quiet
    - repl: ""

{{sls}} - Remove 'splash':
  file.replace:
    - name: /etc/default/grub
    - pattern: splash
    - repl: ""

{{sls}} - Rerun grub:
  cmd.wait:
    - name: update-grub
    - watch:
      - file: {{sls}} - Remove 'quiet'
      - file: {{sls}} - Remove 'splash'
