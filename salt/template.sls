{% if 2015 > grains['saltversioninfo'][0] %}
{%   set tpldir = '' %}
{%   set tplfile = tpldir ~ '/template.sls' %}
{% endif %}

include:
  - otherState
  - .otherSubstate

{{tplfile}} - State description:
  state.function:
    - name: template
    - other: option
