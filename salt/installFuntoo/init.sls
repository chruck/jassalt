{% if "sysresccd" == grains["nodename"] %}

include:
  - .prepareHardDisk
  - .mountingFilesystems
  - .downloadTheStage3
  - .mountVirtFs
  - .chrootIntoFuntoo
  - .dlPortageTree
  - .fstab
  - .localtime
  - .makeConf
  - .umountSda

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
