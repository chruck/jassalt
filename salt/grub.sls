{% for dontwant in 'quiet', 'splash', 'rhgb', 'zswap.enabled=.',
        'zswap.compressor\S*' %}
{{sls}} - Remove '{{dontwant}}':
  file.replace:
    - name: /etc/default/grub
    - pattern: {{dontwant}}
    - repl: ""
    - watch_in:
      - {{sls}} - Regenerate initramfs files w/ dracut
    - onchanges_in:
      - {{sls}} - Rerun grub
{% endfor %}

# Not sure, this step may be Fedora-only:
{{sls}} - Add lz4 to dracut:
  file.managed:
    - name: /etc/dracut.conf.d/lz4.conf
    - contents: 'add_drivers+="lz4 lz4_compress"'

# Not sure, this step may be Fedora-only:
{{sls}} - Regenerate initramfs files w/ dracut:
  cmd.run:
    - name: dracut --regenerate-all --force
    - watch:
      - {{sls}} - Add lz4 to dracut

# Not sure, this step may be Fedora-only:
{{sls}} - Add zswap to kernel commandline:
  file.replace:
    - name: /etc/default/grub
    - pattern: '^(GRUB_CMDLINE_LINUX="[^"]*)'
    - repl: '\1 zswap.enabled=1 zswap.compressor=lz4 '

{{sls}} - Rerun grub:
  cmd.run:
    #- name: update-grub
    - name: grub2-mkconfig -o /boot/grub2/grub.cfg
