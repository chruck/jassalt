{% if "sysresccd" == grains["nodename"] %}

include:
  - .sda2
  - .mountsda2

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
