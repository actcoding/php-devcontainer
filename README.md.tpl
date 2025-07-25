# php-devcontainer

> A custom devcontainer image suited for Php development.

## Supported tags
{{ range (ds "data") }}
- {{ . }}
{{- end }}

## Contents

### Tools

- zsh
- [atuin](https://atuin.sh/)
- [starship](https://starship.rs/)
- composer
- nano

### Php Extensions

- xdebug
- pgsql
- pdo_pgsql
- redis
- opcache
- pcntl
- zip
- intl

### Language Server

[phpactor/phpactor](https://github.com/phpactor/phpactor)

The binary lives at `/opt/phpactor/bin/phpactor`
