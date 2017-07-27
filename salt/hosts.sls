{{sls}} - Add tiger to /etc/hosts:
#  file.append:
#    - name: /etc/hosts
#    - text:
#      - "172.16.16.100 tiger"
  host.present:
    - name: tiger
    - ip: 172.16.16.100

{{sls}} - Add grace to /etc/hosts:
#  file.append:
#    - name: /etc/hosts
#    - text:
#      - "172.16.16.107 grace salt"
  host.present:
    - name: grace
    - ip: 172.16.16.107

{{sls}} - Add alarm to /etc/hosts:
#  file.append:
#    - name: /etc/hosts
#    - text:
#      - "172.16.16.131 alarm"
  host.present:
    - name: alarm
    - ip: 172.16.16.131

{{sls}} - Add iac to /etc/hosts:
#  file.append:
#    - name: /etc/hosts
#    - text:
#      - "172.16.16.106 iac"
  host.present:
    - name: iac
    - ip: 172.16.16.122

{{sls}} - Add localhost as saltmaster to /etc/hosts:
#  file.append:
#    - name: /etc/hosts
#    - text:
#      - "127.0.0.1 salt"
  host.only:
    - name: 127.0.0.1
    - hostnames:
      - {{grains['fqdn']}}
      - {{grains['nodename']}}
      - localhost
      - localhost.localdomain
      - salt
