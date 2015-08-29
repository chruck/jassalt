{% set baseURL = "salt://hosts" %}

{{baseURL}} - Add tiger to /etc/hosts:
  file.append:
    - name: /etc/hosts
    - text:
      - "172.16.16.100 tiger"

{{baseURL}} - Add grace to /etc/hosts:
  file.append:
    - name: /etc/hosts
    - text:
      - "172.16.16.107 grace salt"

{{baseURL}} - Add alarm to /etc/hosts:
  file.append:
    - name: /etc/hosts
    - text:
      - "172.16.16.131 alarm "
