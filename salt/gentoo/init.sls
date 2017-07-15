{% if "Gentoo" == grains.os %}

include:
  - .useflags
  - .software

{% endif %}  # Gentoo
