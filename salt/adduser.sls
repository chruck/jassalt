{{sls}} - Create user '{{pillar.user}}':
  user.present:
    - name: {{pillar['user']}}
    - fullname: Jas
    - shell: /bin/bash
    #- home: /home/{{pillar['user']}}
    - password: $6$mLWkWhz7$XHI6MwUCXWVmrhwge2E7yOq/USreFgLu.Z1TW/c5qjCY4wwtN3vRdAmKu8PAzaUKIn8yXqkx1ykE7jCzx3BVZ/
    #- uid: 1000
    #- gid: 1000
    - gid_from_name: True
    - groups:
      - adm
