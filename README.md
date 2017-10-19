# macbuild

## Requirements
Make sure you have a clean installation of Mac OS.

> An already configured admin account.

## Initial Setup

### Host Machine

### Checking the project out
You can check the project out from https://github.com/uzubair/ansible-mac-setup. If you're more comfortable using command line, use:

```bash
git clone https://github.com/uzubair/ansible-mac-setup.git
cd ansible-mac-setup
```

### Pre-Run Setup

Pre run setup script installs:
- Xcode
- Python
- Pip
  - Jinja2
  - MarkupSafe
  - PyYAML
  - ecdsa
  - paramiko
  - pycrypto
  - pexpect
  - ansible
- Homebrew 
- Homebrew Cask 

```bash
./ansible_setup.sh      # pre-run machine setup
```
### Setup

The following commands will setup the minimum requirements.

```bash
ansible-playbook -c local -i hosts -vv provision.yml 
```

## Applications/ Packages Installed
Homebrew packages installed
  - curl
  - git
  - ruby
  - expect

Homebrew Cask packages installed
  - java
