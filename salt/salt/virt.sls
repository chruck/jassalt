{{sls}} - Install libvirt:
  pkg.installed:
    - name: libvirt-bin

{{sls}} - Config libvirt:
  file.append:
    - name: /etc/default/libvirt-bin
    - text: libvirtd_opts="-l"
    - require:
      - pkg: {{sls}} - Install libvirt

{{sls}} - Manage libvirt keys:
  virt.keys:
    - name:  libvirt_keys
    - require:
      - pkg: {{sls}} - Install libvirt

{{sls}} - Daemonize libvirt:
  service.running:
    - name: libvirtd
    - require:
      - pkg: {{sls}} - Install libvirt
      - network: br0
      - libvirt: libvirt
    - watch:
      - file: {{sls}} - Config libvirt

{{sls}} - Install libvirt-python:
  pkg.installed:
    - name: libvirt-python

{{sls}} - Install libguestfs:
  pkg.installed:
    - pkgs:
      - libguestfs
      - libguestfs-tools
