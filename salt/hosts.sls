{% set baseURL = "salt://hosts" %}

{{baseURL}} - Add tiger to /etc/hosts
  file.append:
    - name: /etc/hosts
    - text:
      172.16.16.121 tiger
