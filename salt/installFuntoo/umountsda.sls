{% if "sysresccd" == grains["nodename"] %}

{% set mntPt = "/mnt/funtoo" %}

{{sls}} - Unmount {{mntPt}}/sys:
  mount.unmounted:
    - name: {{mntPt}}/sys

{{sls}} - Unmount {{mntPt}}/dev:
  mount.unmounted:
    - name: {{mntPt}}/dev

{{sls}} - Unmount {{mntPt}}/proc:
  mount.unmounted:
    - name: {{mntPt}}/proc

{{sls}} - Unmount {{mntPt}}:
  mount.unmounted:
    - name: {{mntPt}}
    - mount: {{sls}} - Unmount {{mntPt}}/proc

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
