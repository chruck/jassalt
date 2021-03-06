{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        mntPt,
        mntFstab,
        umountSda,
        installSalt,
        setYourRootPassword,
        configuringYourNetworkWiFi,
        oldSchoolBiosMbr,
        configurationFilesfstab,
        with context %}

include:
  - {{umountSda}}
  - {{configurationFilesfstab}}

{{sls}} - Reboot:
  cmd.run:
    - name: reboot
    - require:
      - mount: {{umountSda}} - Unmount {{mntPt}}
      - cmd: {{installSalt}} - Start salt-minion at startup
      - file: {{setYourRootPassword}} - Set root's password
      - cmd: {{configuringYourNetworkWiFi}} - Start NetworkManager at startup
      - cmd: {{oldSchoolBiosMbr}} - Install grub to MBR of /dev/sda
      - mount: {{configurationFilesfstab}} - Add / to {{mntFstab}}

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
