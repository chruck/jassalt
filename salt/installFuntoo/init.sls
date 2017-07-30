{% if "sysresccd" == grains["nodename"] %}

include:
  - .prepareHardDisk
  - .mountingFilesystems
  - .installingTheStage3Tarball
  - .mountVirtFs
  - .chrootIntoFuntoo
  - .downloadingThePortageTree
  - .configurationFiles-fstab
  - .configurationFiles-localtime
  - .configurationFiles-makeConf
  - .updatingWorld
  - .installingABootloader
  - .oldSchoolBiosMbr
  - .configuringYourNetwork-Wi-Fi
  - .configuringYourNetwork-Hostname
  - .setYourRootPassword
  - .installSalt
  - .umountSda
  - .restartYourSystem

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
