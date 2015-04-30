{% set baseURL = "salt://musthaves/git" %}

# Separated out to satisfy another state

{{baseURL}} - Install git package:
  pkg.installed:
    - name: git
    - install_recommends: False

{{baseURL}} - Install git-completion package:
  pkg.installed:
    - name: git-completion
    - install_recommends: False

{{baseURL}} - Install git-doc package:
  pkg.installed:
    - name: git-doc
    - install_recommends: False
