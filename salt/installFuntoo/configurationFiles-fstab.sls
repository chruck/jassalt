{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        harddriveDev,
        mntPt,
        mntFstab,
        mountAsFuntoo,
        mountingFilesystems,
        with context %}

include:
  - {{mountingFilesystems}}

{{sls}} - Remove all {{harddriveDev}}*'s from {{mntFstab}}:
  file.line:
    - name: {{mntFstab}}
    - match: {{harddriveDev}}
    - content:
    - mode: delete
    - require:
      - {{mountAsFuntoo}}

{{sls}} - Remove swap from {{mntFstab}}:
  file.line:
    - name: {{mntFstab}}
    - match: swap
    - content:
    - mode: delete
    - require:
      - {{mountAsFuntoo}}

{{sls}} - Remove /boot from {{mntFstab}}:
  #file.comment:
  mount.unmounted:
    - name: /boot
    - config: {{mntFstab}}
    - persist: True
    - require:
      - {{mountAsFuntoo}}

{{sls}} - Add / to {{mntFstab}}:
  mount.mounted:
    - name: /
    - mount: False
    - config: {{mntFstab}}
    - device: {{harddriveDev}}
    - fstype: btrfs
    - dump: 1
    - opts: rw,relatime,ssd,space_cache,subvolid=5,subvol=/
    - pass_num: 1
    - require:
      - {{mountAsFuntoo}}

{#
{{sls}} - Add /proc to {{mntFstab}}:
  mount.mounted:
    - name: /proc
    - mount: False
    - config: {{mntFstab}}
    - device: proc
    - fstype: proc
    - require:
      - {{mountAsFuntoo}}

{{sls}} - Add /sys to {{mntFstab}}:
  mount.mounted:
    - name: /sys
    - mount: False
    - config: {{mntFstab}}
    - device: /sys
    - fstype: sysfs
    - require:
      - {{mountAsFuntoo}}

{{sls}} - Add /dev to {{mntFstab}}:
  mount.mounted:
    - name: /dev
    - mount: False
    - config: {{mntFstab}}
    - device: /dev
    - fstype: devtmpfs
    - require:
      - {{mountAsFuntoo}}
#}

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
