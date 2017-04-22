{% if 2015 > grains['saltversioninfo'][0] %}
{%   set tpldir = '' %}
{%   set tplfile = tpldir ~ '/template.sls' %}
{% endif %}

{{sls}} - Format /dev/sda:
  blockdev.formatted:
    - name: /dev/sda
    - fs_type: btrfs
