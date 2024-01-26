# Personal Nix Configuration

Hello! You've stumble upon my current nixos configuration.
This is a project which I currently use to maintain my
personal desktop workstation with features like:
- Single command install through `./install.sh`
- Host (and hopefully full network monitoring) through zabbix
- A full wayfire/greetd/systemd/gnu/linux system configured for development and gaming

## TODO
- Document usage of ./install.sh
- Get sops based password hashes working again
- Set up nixos-generators to allow for vm creation
- Create and test configuration for general home lab server
- Deploy home lab server to the home lab
- Setup nixops to enable networked host management
- Network the zabbix agents to allow central monitoring of events
- Set up k8s node on homelab
- Containerize zabbix, minecraft, necesse, and openmw servers
