{% if "sysresccd" == grains["nodename"] %}

{{sls}} - Unmount /mnt/funtoo:
  mount.unmounted:
    - name: /mnt/funtoo

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
