{% set baseURL = "salt://grub" %}

{{baseURL}} - Remove 'quiet':
  file.comment:
    - name: /etc/default/grub
    - regex: ^GRUB_CMDLINE_LINUX_DEFAULT=.*quiet

{{baseURL}} - Remove 'splash':
  file.comment:
    - name: /etc/default/grub
    - regex: ^GRUB_CMDLINE_LINUX_DEFAULT=.*splash

{{baseURL}} - Rerun grub:
  cmd.wait:
    - name: update-grub
    - watch:
      - file: {{baseURL}} - Remove 'quiet'
      - file: {{baseURL}} - Remove 'splash'
