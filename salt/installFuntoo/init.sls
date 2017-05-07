{% if "sysresccd" == grains["nodename"] %}

include:
  - .sda
  - .mountSda
  - .getStage3
  - .mountVirtFs
  - .chrootInto
  - .dlPortageTree
  - .fstab
  - .umountSda

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
