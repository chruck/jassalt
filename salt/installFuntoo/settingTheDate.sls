{% if "sysresccd" == grains["nodename"] %}

{{sls}} - Set the time:
  cmd.run:
    - name: ntpdate pool.ntp.org

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
