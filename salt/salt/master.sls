{% from "salt/map.jinja" import githubURL, jassaltDir, srcDir with context %}

{#
{% set githubURL = "https://github.com/chruck" %}
{% set srcDir = "/usr/src" %}
#}
{% set srvDir = "/srv" %}
{% set saltDir = srvDir ~ "/salt" %}
{% set pillarDir = srvDir ~ "/pillar" %}
{#
{% set jassaltDir = srcDir ~ "/jassalt" %}
#}
{% set bashrcDir = srcDir ~ "/dot.bashrc.jas" %}

include:
  - musthaves.git
  - bashrc
  - .minion
  - .jassalt

{{sls}} - Install salt-master pkg:
  pkg.latest:
    - name: salt-master
    - refresh: True

{{sls}} - Set hash to SHA512:
  file.managed:
    - name: /etc/salt/master.d/hash.conf
    - contents: "hash_type: sha512"
    - require:
      - {{sls}} - Install salt-master pkg

{{sls}} - Set file_ignore:
  file.managed:
    - name: /etc/salt/master.d/file_ignore.conf
    - source: salt://salt/file_ignore.conf
    - require:
      - {{sls}} - Install salt-master pkg

{#
{{sls}} - Pull down the latest jassalt salt states:
  git.latest:
    - name: {{githubURL}}/jassalt.git
    - target: {{jassaltDir}}
    - force_reset: True
    - require:
      - pkg: git
#}

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
      - musthaves.git - Install {{musthaves.gitpkgs[0]}} package
    - require_in:
      - bashrc - Upload root's .bashrc.jas

{{sls}} - Symlink for {{saltDir}}/.bashrc.jas:
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
      - musthaves.git - Install {{musthaves.gitpkgs[0]}} package
      - "{{sls}} - Symlink for {{saltDir}}"
      - "{{sls}} - Create {{srvDir}}"
