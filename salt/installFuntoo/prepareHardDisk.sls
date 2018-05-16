{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        harddriveDev,
        mntDev,
        with context %}
{# set luksPasswd = salt['pillar.get']('luks:passwd', 'passwd') #}

#{{sls}} - Label {{harddriveDev}} as GPT:
#  module.run:
#    - name: partition.mklabel
#    - device: {{harddriveDev}}
#    - label_type: gpt
#    - label_type: msdos

#{{sls}} - Create partition {{harddriveDev}}1 as fat32:
#  module.run:
#    - name: partition.mkpart
#    - device: {{harddriveDev}}
#    - part_type: primary
#    - fs_type: fat32
#    - start: 2048s
#    - end: 534527s
#    - start: 0
#    - end: 260

#{{sls}} - Create partition {{harddriveDev}}2 as btrfs:
#  module.run:
#    - name: partition.mkpart
#    - device: {{harddriveDev}}
#    - part_type: primary
#    - fs_type: btrfs
#    - start: 534528s
#    - end: -1s
#    - end: 1000215182s
#    - start: 260

{{sls}} - Format {{harddriveDev}} as LUKS:
  cmd.run:
#    - name: cryptsetup luksFormat --cipher aes-xts-plain64 --hash sha512 --key-size 512 {{harddriveDev}}
#zettaknight:    - name: cryptsetup luksFormat --cipher aes-xts-plain --hash sha256 --key-size 512 {{harddriveDev}}
    - name: cryptsetup luksFormat --cipher aes-xts-plain64 {{harddriveDev}} <<< {{pillar['luks:passwd']}}

{{sls}} - Make {{harddriveDev}} a mapper device named {{mapperName}}:
  cmd.run:
    - name: cryptsetup luksOpen {{harddriveDev}} {{mapperName}}
    - require:
      - {{sls}} - Format {{harddriveDev}} as LUKS

#{{sls}} - Format {{mntDev}} (cmd.run):
#  cmd.run:
#    - name: "mkfs.btrfs {{mntDev}} -f"

{{sls}} - Format {{mntDev}} (module.run):
  module.run:
    - name: btrfs.mkfs
    - devices:
      - {{mntDev}}
    - require:
      - {{sls}} - Make {{harddriveDev}} a mapper device named {{mapperName}}

{{sls}} - Format {{mntDev}}
  blockdev.formatted:
    - name: {{mntDev}}
    - fs_type: btrfs
    - force: True
    - require:
#      - {{sls}} - Format {{mntDev}} (cmd.run)
      - {{sls}} - Format {{mntDev}} (module.run)

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
