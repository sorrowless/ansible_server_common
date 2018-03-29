sbog/server_common
==================

Role to manage common server settings, like:
* dns hostname
* default packages list
* users list

#### Requirements

Ansible 2.4

#### Role Variables

```yaml
server_common_group:
  # Host default packages
  packages:
    - atop
    - sysstat
    - iotop
    - iftop
    - python
    - git
  # Host DNS name
  dns_hostname: localhost
  users: []
  # By default we do not include any user to not intrude to your system. Here
  # is an example of users list:
  # users:
  #    - name: admin
  #      comment: "Administrator. Ask anything at sbog@sbog.ru."
  #      groups: sudo
  #      remove: no
  #      state: present
  #      # Gen pass by python -c 'import crypt; print(crypt.crypt("This is my Password", "$1$blackgolem$"))'
  #      password: "$1$blackgol$bIR4q4z6bvbLIleUt4jOK0"
  #      ssh_keys:
  #        - name: https://github.com/username.keys
  #          state: present
server_common_host: {}
```

Above list is the defaults. You can override it by setting your own data in
group_vars or host_vars by overriding the whole dict or just setting some data
of it - it will be merged with defaults anyway. `server_common_host` there
have a precedence over `server_common_group` which has precedence over default
values.

#### Dependencies

None

#### Example Playbook

```yaml
- name: Do common things on server
  hosts: localhost
  remote_user: root
  roles:
    - { role: server_common, tags: ['common'] }
```

#### License

Apache 2.0

#### Author Information

Stanislaw Bogatkin (https://sbog.ru)
