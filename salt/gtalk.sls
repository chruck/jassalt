{% if 2015 > grains['saltversioninfo'][0] %}
{%   set tpldir = '' %}
{%   set tplfile = tpldir ~ '/gtalk.sls' %}
{% endif %}

{{sls}} - Install Google Talk plugin package:
  - pkg.installed:
    - name: google-talkplugin_current_amd64
    - source: https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb
