{% if "Gentoo" == grains.os %}

include:
  - .useflags
  - .otherpackages

{% endif %}  # Gentoo
