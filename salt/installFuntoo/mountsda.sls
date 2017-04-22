{% if "sysresccd" == grains["nodename"] %}

include:
  - .sda

{{sls}} - Mount btrfs /dev/sda as /mnt/funtoo:
  mount.mounted:
    - name: /mnt/funtoo
    - device: /dev/sda
    #- pass_num: 1
    - mkmnt: True
    - require:
      - blockdev: installFuntoo.sda - Format /dev/sda

{% endif %}
