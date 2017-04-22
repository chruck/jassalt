{{sls}} - Add tiger to /etc/hosts:
  file.append:
    - name: /etc/hosts
    - text:
      - "172.16.16.100 tiger"

{{sls}} - Add grace to /etc/hosts:
  file.append:
    - name: /etc/hosts
    - text:
      - "172.16.16.107 grace salt"

{{sls}} - Add alarm to /etc/hosts:
  file.append:
    - name: /etc/hosts
    - text:
      - "172.16.16.131 alarm"
