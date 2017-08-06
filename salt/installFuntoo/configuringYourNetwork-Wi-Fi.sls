{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        bindMountDev,
        configurationFilesMakeConf,
        downloadingThePortageTree,
        emergeSync,
        makeConfFile,
        mntPt,
        mountVirtFs,
        numThreads,
        with context %}
{% from tpldir ~ "/headtail.jinja" import headtail with context %}

include:
  - {{mountVirtFs}}
  - {{downloadingThePortageTree}}
  - {{configurationFilesMakeConf}}

{{sls}} - Install NetworkManager and Linux Firmware:
  cmd.run:
    - name: "/bin/chroot {{mntPt}} emerge linux-firmware networkmanager {{headtail}}"
    - require:
      - {{emergeSync}}
      - {{bindMountDev}}
      - {{configurationFilesMakeConf}} - Set MAKEOPTS, USE, and CFLAGS in {{makeConfFile}}

# Output to emerging networkmanager:
#
# * To modify system network connections without needing to enter the
# * root password, add your user account to the 'plugdev' group.
# *
# * (Note: Above message is only printed the first time package is
# * installed. Please look at /usr/share/doc/networkmanager-1.4.4-r1/README.gentoo*
# * for future reference)

# Output to emerging wpa_supplicant:
# * If this is a clean installation of wpa_supplicant, you
# * have to create a configuration file named
# * /etc/wpa_supplicant/wpa_supplicant.conf
# *
# * An example configuration file is available for reference in
# * /usr/share/doc/wpa_supplicant-2.6-r1/

{{sls}} - Start NetworkManager at startup:
  cmd.run:
    - name: /bin/chroot {{mntPt}} rc-update add NetworkManager default
    - require:
      - {{sls}} - Install NetworkManager and Linux Firmware

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
