{% set baseURL = "salt://musthaves/git" %}

# Separated out to satisfy another state

{{baseURL}} - Install git package:
  pkg.latest:
    - name: git
    - install_recommends: False

{% if 'RedHat' != grains['os_family'] %}
{{baseURL}} - Install git-completion package:
  pkg.latest:
    - name: git-completion
    - install_recommends: False

{{baseURL}} - Install git-doc package:
  pkg.latest:
    - name: git-doc
    - install_recommends: False
{% endif %}
