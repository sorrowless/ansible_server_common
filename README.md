# sbog/server_common

Role to manage common server settings, like:
* dns hostname
* default packages list
* users list

## Requirements

Ansible 2.4

## Role Variables

You can see all vars in `defaults/main.yml` vars file.

You can override defaults by setting your own data in
group_vars or host_vars by overriding the whole dict or just setting some data
of it - it will be merged with defaults anyway. `server_common_host` there
have a precedence over `server_common_group` which has precedence over default
values.

## Dependencies

None

## Example Playbook

```yaml
- name: Do common things on server
  hosts: localhost
  remote_user: root
  roles:
    - { role: server_common, tags: ['common'] }
```

## License

Apache 2.0

## Author Information

This role was created by [Stan Bogatkin](https://sbog.ru).
