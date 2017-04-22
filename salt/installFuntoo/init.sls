{% if "sysresccd" == grains["nodename"] %}

include:
  - .sda
  - .mountsda

{% endif %}
