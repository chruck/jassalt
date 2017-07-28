{% if "sysresccd" == grains["nodename"] %}

{% from tpldir ~ "/vars.jinja" import
        mntPt,
        makeConfFile,
        mountingFilesystems,
        numThreads,
        with context %}

include:
  - {{mountingFilesystems}}

{{sls}} - Set MAKEOPTS, USE, and CFLAGS in {{makeConfFile}}:
  file.append:
    - name: {{makeConfFile}}
    - text:
      - CFLAGS="-Os -pipe -march=native"
      - CXXFLAGS="${CFLAGS}"
      - MAKEOPTS="-j{{numThreads}}"
      - USE="X alsa bluetooth btrfs cups dbus hardened icu networkmanager pulseaudio sound symlink xcomposite xinerama xrandr -mercurial -modemmanager -ppp"
    - require:
      - {{mountingFilesystems}} - Mount btrfs /dev/sda as /mnt/funtoo

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
