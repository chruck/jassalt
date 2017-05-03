{% if "sysresccd" == grains["nodename"] %}

include:
  - .sda
  - .mountsda
  - .getStage3

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
