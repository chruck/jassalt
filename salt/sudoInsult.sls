{% if 2015 > grains['saltversioninfo'][0] %}
{%   set tpldir = '' %}
{%   set tplfile = tpldir ~ '/sudoInsult.sls' %}
{% endif %}

include:
  - otherState
  - .otherSubstate

{{sls}} - Set sudo to insult you when you put in a bad password:
  file.managed:
    - name: /etc/sudoers.d/insults
    - contents: Defaults insults
