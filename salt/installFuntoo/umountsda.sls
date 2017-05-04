{% if "sysresccd" == grains["nodename"] %}

{% set mntPt = "/mnt/funtoo" %}
{% set sysMntPt = mntPt ~ "/sys" %}
{% set devMntPt = mntPt ~ "/dev" %}

{{sls}} - Unmount {{sysMntPt}}/kernel/config:
  mount.unmounted:
    - name: {{sysMntPt}}/kernel/config

{{sls}} - Unmount {{sysMntPt}}/kernel/debug:
  mount.unmounted:
    - name: {{sysMntPt}}/kernel/debug

{{sls}} - Unmount {{sysMntPt}}/kernel/security:
  mount.unmounted:
    - name: {{sysMntPt}}/kernel/security

{{sls}} - Unmount {{sysMntPt}}/fs/fuse/connections:
  mount.unmounted:
    - name: {{sysMntPt}}/fs/fuse/connections

{{sls}} - Unmount {{sysMntPt}}/firmware/efi/efivars:
  mount.unmounted:
    - name: {{sysMntPt}}/firmware/efi/efivars

{{sls}} - Unmount {{sysMntPt}}:
  mount.unmounted:
    - name: {{sysMntPt}}
    - require:
      - mount: {{sls}} - Unmount {{sysMntPt}}/kernel/config
      - mount: {{sls}} - Unmount {{sysMntPt}}/kernel/debug
      - mount: {{sls}} - Unmount {{sysMntPt}}/kernel/security
      - mount: {{sls}} - Unmount {{sysMntPt}}/fs/fuse/connections
      - mount: {{sls}} - Unmount {{sysMntPt}}/firmware/efi/efivars

{{sls}} - Unmount {{devMntPt}}/shm:
  mount.unmounted:
    - name: {{devMntPt}}/shm

{{sls}} - Unmount {{devMntPt}}/pts:
  mount.unmounted:
    - name: {{devMntPt}}/pts

{{sls}} - Unmount {{devMntPt}}/mqueue:
  mount.unmounted:
    - name: {{devMntPt}}/mqueue

{{sls}} - Unmount {{devMntPt}}:
  mount.unmounted:
    - name: {{devMntPt}}
    - require:
      - mount: {{sls}} - Unmount {{devMntPt}}/shm
      - mount: {{sls}} - Unmount {{devMntPt}}/pts
      - mount: {{sls}} - Unmount {{devMntPt}}/mqueue

{{sls}} - Unmount {{mntPt}}/proc:
  mount.unmounted:
    - name: {{mntPt}}/proc

{{sls}} - Unmount {{mntPt}}:
  mount.unmounted:
    - name: {{mntPt}}
    - require:
      - mount: {{sls}} - Unmount {{sysMntPt}}
      - mount: {{sls}} - Unmount {{devMntPt}}
      - mount: {{sls}} - Unmount {{mntPt}}/proc

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
