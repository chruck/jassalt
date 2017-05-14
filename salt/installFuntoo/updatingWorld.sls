{% if "sysresccd" == grains["nodename"] %}

{% set mntPt = "/mnt/funtoo" %}

#include:
#  - .downloadingThePortageTree

{{sls}} - Update @world:
  cmd.run:
    - name: /bin/chroot {{mntPt}} emerge -uDN @world
#    - require:
#      - installFuntoo.downloadingThePortageTree - Download Portage Tree

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
