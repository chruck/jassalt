{% if "Gentoo" == grains.os %}

{{sls}} - Accept license for Adobe Flash:
  file.replace:
    - name: /etc/portage/package.license
    - pattern: .*adobe-flash.*
    - repl: >=www-plugins/adobe-flash-26.0.0.131 AdobeFlash-11.x
    - append_if_not_found: True
    - require_in:
      - musthaves.desktop - Must-Haves for Desktop

{% endif %}
