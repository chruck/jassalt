{% if "sysresccd" == grains["nodename"] %}

include:
  - .sda
  - .mountsda

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'.":
  cmd.run
{% endif %}
