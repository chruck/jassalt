{% if "sysresccd" == grains["nodename"] %}

include:
  - .sda
  - .mountsda
  - .getStage3
  - .mountvirtfs
  - .chrootInto
  - .dlportagetree
  - .umountsda

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
