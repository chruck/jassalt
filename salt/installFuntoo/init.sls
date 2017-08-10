{% if "sysresccd" == grains["nodename"] %}

include:
  - .prepareHardDisk
  - .mountingFilesystems
  - .settingTheDate
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
  - .patchFakeFuntooIsGentoo
  - .umountSda
  - .restartYourSystem

{% else %}
echo "Not installing on '{{grains["nodename"]}}'; expecting 'sysresccd'."; exit 1:
  cmd.run
{% endif %}
