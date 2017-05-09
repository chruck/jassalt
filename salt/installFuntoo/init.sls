{% if "sysresccd" == grains["nodename"] %}

include:
  - .sda
  - .mountSda
  - .getStage3
  - .mountVirtFs
  - .chrootInto
  - .dlPortageTree
  - .fstab
  - .localtime
  - .makeConf
  - .umountSda

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
