# Separated out to satisfy another state

{{sls}} - Install git package:
  pkg.latest:
    - name: git
    - refresh: True
    - install_recommends: False

{% if 'RedHat' != grains['os_family'] %}
{{sls}} - Install git-completion package:
  pkg.latest:
    - name: git-completion
    - refresh: True
    - install_recommends: False

{{sls}} - Install git-doc package:
  pkg.latest:
    - name: git-doc
    - refresh: True
    - install_recommends: False
{% endif %}
