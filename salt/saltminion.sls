{% set baseURL = "salt://saltminion" %}

{{baseURL}} - Install salt-minion pkg:
  pkg.latest:
    - name: salt-minion
