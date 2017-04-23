# installFuntoo
States to install Funtoo distribution on a target node.

## Assumptions
* Target booted into [SystemRescueCD].
* Target has root password changed with `passwd` command.
* Target's IP address is `$IP` (use `ip a` to find it).
* Target's hostname is unchanged from `sysresccd`.
* Salt master has `salt-ssh` installed.
* Salt master has target in `/etc/salt/roster` (`salt.master` state):
```sh
echo sysresccd: $IP >/etc/salt/roster
```

## Commands to run
* Initiate connection from salt-ssh to target (will prompt for password,
changed above, to exchange keys):
```sh
sudo salt-ssh -i sysresccd test.ping
```
* Install Funtoo:
```sh
sudo salt-ssh sysresccd state.apply installFuntoo
```

[SystemRescueCD]: http://www.system-rescue-cd.org/
