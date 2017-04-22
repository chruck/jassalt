include:
  - .sda

{{sls}} - Mount btrfs /dev/sda as /mnt/funtoo:
  mount.mounted:
    - name: /mnt/funtoo
    - device: /dev/sda
    - pass_num: 1
    - require:
      - blockdev: sda - Format /dev/sda
