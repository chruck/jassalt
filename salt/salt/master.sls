{% from "salt/map.jinja" import githubURL, jassaltDir, pkg, srcDir with context %}
{% from "musthaves/map.jinja" import musthaves with context %}

{% set srvDir = "/srv" %}
{% set saltDir = srvDir ~ "/salt" %}
{% set pillarDir = srvDir ~ "/pillar" %}
{% set bashrcDir = srcDir ~ "/dot.bashrc.jas" %}
{% set masterDir = "/etc/salt/master.d" %}

include:
  - gentoo
  - musthaves.git
  - bashrc
  - .minion
  - .jassalt

{{sls}} - Install salt-master pkg:
  pkg.installed:
    - name: {{pkg.master}}
    - refresh: True

{{sls}} - Create {{masterDir}}:
  file.directory:
    - name: {{masterDir}}

{{sls}} - Set hash to SHA512:
  file.managed:
    - name: {{masterDir}}/hash.conf
    - contents: "hash_type: sha512"
    - require:
      - {{sls}} - Install salt-master pkg
      - {{sls}} - Create {{masterDir}}

{{sls}} - Set file_ignore:
  file.managed:
    - name: {{masterDir}}/file_ignore.conf
    - source: salt://salt/file_ignore.conf
    - require:
      - {{sls}} - Install salt-master pkg
      - {{sls}} - Create {{masterDir}}

{{sls}} - Ensure salt-master service is running:
  service.running:
    - name: salt-master
    - enable: True
    - require:
      - {{sls}} - Install salt-master pkg

{{sls}} - Create {{srvDir}}:
  file.directory:
    - name: {{srvDir}}

{{sls}} - Symlink for {{saltDir}}:
  file.symlink:
    - name: {{saltDir}}
    - target: {{jassaltDir}}/salt
    - require:
      - {{sls}} - Create {{srvDir}}

{{sls}} - Symlink for {{pillarDir}}:
  file.symlink:
    - name: {{pillarDir}}
    - target: {{jassaltDir}}/pillar
    - require:
      - {{sls}} - Create {{srvDir}}

{{sls}} - Pull down the latest .bashrc.jas:
  git.latest:
    - name: {{githubURL}}/dot.bashrc.jas.git
    - target: {{bashrcDir}}
    - force_reset: True
    - require:
      - musthaves.git - Install {{musthaves.gitpkg}} package
    - require_in:
      - bashrc - Upload root's .bashrc.jas

{{sls}} - Symlink for {{bashrcDir}}/.bashrc.jas:
  file.symlink:
    - name: {{saltDir}}/bashrc/.bashrc.jas
    - target: {{bashrcDir}}/.bashrc.jas
    - require:
      - {{sls}} - Create {{srvDir}}
    - require_in:
      - "bashrc - Upload root's .bashrc.jas"
      - "bashrc - Upload Jas' .bashrc.jas"

{{sls}} - Pull down the latest dnsmasq formula:
  git.latest:
    - name: https://github.com/saltstack-formulas/dnsmasq-formula.git
    - target: {{saltDir}}/dnsmasq-formula
    - force_reset: True
    - require:
      - musthaves.git - Install {{musthaves.gitpkg}} package
      - "{{sls}} - Symlink for {{saltDir}}"
      - "{{sls}} - Create {{srvDir}}"

#{{sls}} - Install CIFS-mounting software:
#  pkg.installed:
#    - name: cifs-utils
#    - refresh: True

{{sls}} - Mount isoarchive:
  mount.mounted:
    - name: /mnt/isoarchive
#    - device: //isoarchive.zfs.clemson.edu/isoarchive
    - device: isoarchive.zfs.clemson.edu:zfs_data/isoarchive
#    - fstype: cifs
    - fstype: nfs
    - mkmnt: True
#    - opts: 'user=eckard,passwd={{pillar.passwd}}'
#    - require:
#      - {{sls}} - Install CIFS-mounting software
