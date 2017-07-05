{% if "Gentoo" == grains.os %}

{% set file = "/etc/portage/package.license" %}

{{sls}} - Touch {{file}}:
  file.touch:
    - name: {{file}}
    - only_if: "! ls {{file}}"

{{sls}} - Accept license for Adobe Flash:
  file.replace:
    - name: {{file}}
    - pattern: .*adobe-flash.*
    - repl: ">=www-plugins/adobe-flash-26.0.0.131 AdobeFlash-11.x"
    - append_if_not_found: True
    - require:
      - {{sls}} - Touch {{file}}
    - require_in:
      - musthaves.desktop - Must-Haves for Desktop

{% endif %}
