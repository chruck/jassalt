{% if 2015 > grains['saltversioninfo'][0] %}
{%   set tpldir = '/saltmaster' %}
{% endif %}

{% set githubURL = "https://github.com/chruck" %}
{% set srcDir = "/usr/src" %}
{% set srvDir = "/srv" %}
{% set saltDir = "/srv/salt" %}
{% set pillarDir = "/srv/pillar" %}
{% set jassaltDir = srcDir ~ "/jassalt" %}
{% set bashrcDir = srcDir ~ "/dot.bashrc.jas" %}

include:
  - musthaves.git
  - bashrc
  - saltminion

{{sls}} - Install salt-master pkg:
  pkg.latest:
    - name: salt-master
    - refresh: True

{{sls}} - Set hash to SHA512:
  file.managed:
    - name: /etc/salt/master.d/hash.conf
    - contents: "hash_type: sha512"
    - require:
      - pkg: {{sls}} - Install salt-master pkg

{{sls}} - Set file_ignore:
  file.managed:
    - name: /etc/salt/master.d/file_ignore.conf
    - source: salt://{{tpldir}}/file_ignore.conf
    - require:
      - pkg: {{sls}} - Install salt-master pkg

{{sls}} - Pull down the latest jassalt salt states:
  git.latest:
    - name: {{githubURL}}/jassalt.git
    - target: {{jassaltDir}}
    - require:
      - pkg: git
    #- require_in:
      #- pkg: salt://musthaves - Must-Haves

{{sls}} - Create {{srvDir}}:
  file.directory:
    - name: {{srvDir}}

{{sls}} - Symlink for {{saltDir}}:
  file.symlink:
    - name: {{saltDir}}
    - target: {{jassaltDir}}/salt
    - require:
      - file: {{sls}} - Create {{srvDir}}

{{sls}} - Symlink for {{pillarDir}}:
  file.symlink:
    - name: {{pillarDir}}
    - target: {{jassaltDir}}/pillar
    - require:
      - file: {{sls}} - Create {{srvDir}}

{{sls}} - Pull down the latest .bashrc.jas:
  git.latest:
    - name: {{githubURL}}/dot.bashrc.jas.git
    - target: {{bashrcDir}}
    - require:
      - pkg: git
    - require_in:
      #- pkg: "salt://musthaves - Must-Haves"
      - file: bashrc - Upload root's .bashrc.jas

{{sls}} - Symlink for {{saltDir}}/.bashrc.jas:
  file.symlink:
    - name: {{saltDir}}/bashrc/.bashrc.jas
    - target: {{bashrcDir}}/.bashrc.jas
    - require:
      - file: {{sls}} - Create {{srvDir}}
    - require_in:
      - file: "bashrc - Upload root's .bashrc.jas"
    - require_in:
      - file: "bashrc - Upload Jas' .bashrc.jas"

{{sls}} - Pull down the latest dnsmasq formula:
  git.latest:
    - name: https://github.com/saltstack-formulas/dnsmasq-formula.git
    - target: {{saltDir}}/dnsmasq-formula
    - require:
      - pkg: git
      - file: "{{sls}} - Symlink for {{saltDir}}"
      - file: "{{sls}} - Create {{srvDir}}"
