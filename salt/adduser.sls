include:
  - gentoo.sudo

{{sls}} - Create group '{{pillar.user}}':
  group.present:
    - name: {{pillar.user}}
    - members:
      - {{pillar.user}}

{{sls}} - Create user '{{pillar.user}}':
  user.present:
    - name: {{pillar.user}}
    - fullname: Jas
    - shell: /bin/bash
    - password: $6$mLWkWhz7$XHI6MwUCXWVmrhwge2E7yOq/USreFgLu.Z1TW/c5qjCY4wwtN3vRdAmKu8PAzaUKIn8yXqkx1ykE7jCzx3BVZ/
    - enforce_password: False
    - gid_from_name: True
    - groups:
      - adm
      {% if "Gentoo" == grains.os %}
      - plugdev
      - users
      - wheel
      {% endif %}

{{sls}} - Give {{pillar.user}} full sudo access:
  file.managed:
    - name: /etc/sudoers.d/{{pillar.user}}
    - contents:  {{pillar.user}} ALL=(ALL) ALL
