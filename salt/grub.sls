{% if 2015 > grains['saltversioninfo'][0] %}
{%   set tpldir = '' %}
{%   set tplfile = tpldir ~ '/grub.sls' %}
{% endif %}

{{tplfile}} - Remove 'quiet':
  file.comment:
    - name: /etc/default/grub
    - regex: ^GRUB_CMDLINE_LINUX_DEFAULT=.*quiet

{{tplfile}} - Remove 'splash':
  file.comment:
    - name: /etc/default/grub
    - regex: ^GRUB_CMDLINE_LINUX_DEFAULT=.*splash

{{tplfile}} - Rerun grub:
  cmd.wait:
    - name: update-grub
    - watch:
      - file: {{tplfile}} - Remove 'quiet'
      - file: {{tplfile}} - Remove 'splash'
