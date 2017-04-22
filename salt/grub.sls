{{sls}} - Remove 'quiet':
  file.comment:
    - name: /etc/default/grub
    - regex: ^GRUB_CMDLINE_LINUX_DEFAULT=.*quiet

{{sls}} - Remove 'splash':
  file.comment:
    - name: /etc/default/grub
    - regex: ^GRUB_CMDLINE_LINUX_DEFAULT=.*splash

{{sls}} - Rerun grub:
  cmd.wait:
    - name: update-grub
    - watch:
      - file: {{sls}} - Remove 'quiet'
      - file: {{sls}} - Remove 'splash'
