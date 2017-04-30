{% if "sysresccd" == grains["nodename"] %}

include:
  - .sda
  - .mountsda

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
