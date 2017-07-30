# installFuntoo
States to install Funtoo distribution on a target node.

## Assumptions
* Target booted into [SystemRescueCD].  Suggest choosing
"SystemRescueCd with all files cached to memory" then ejecting media,
so that at reboot, the system boots into the new Funtoo system that
was just built.
* Target has root password changed with `passwd` command.
* Target's IP address is `$IP` (use `ip a` to find it).  Use `nmtui`
to set up WiFi connection.
* Target's hostname is unchanged from `sysresccd`.
* Salt master has `salt-ssh` installed.
* Salt master has target in `/etc/salt/roster` (`salt.master` state):
```sh
echo sysresccd: $IP |sudo tee /etc/salt/roster
```

## Commands to Run
* Initiate connection from salt-ssh to target (will prompt for password,
changed above, to exchange keys):
```sh
sudo salt-ssh -i sysresccd test.ping
```
* Install Funtoo:
```sh
sudo salt-ssh sysresccd state.apply installFuntoo
```
Because Funtoo builds all its software, the above step will take a long
time and not return until done.  The output will scroll beyond the
buffer.  Tests during development of this state showed to be around 75
minutes.
* The state names are based on section headers of [Install Funtoo Linux].
If running each state individually, one at a time, is desired, an
example command would be:
```sh
sudo salt-ssh sysresccd state.apply installFuntoo.chrootIntoFuntoo
```

[SystemRescueCD]: http://build.funtoo.org/distfiles/sysresccd/
[Install Funtoo Linux]: http://www.funtoo.org/Install
