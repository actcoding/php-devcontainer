# php-devcontainer

> A custom devcontainer image suited for Php development.

## Supported tags
{{ range (ds "data") }}
- {{ . }}
{{- end }}

## Contents

### Tools

- zsh
- nano
- [atuin](https://atuin.sh/)
- [starship](https://starship.rs/)
- [composer](https://getcomposer.org/)

### Php Extensions

- xdebug
- redis
- pgsql
- pdo_pgsql
- opcache
- pcntl
- zip
- intl
- gd

### Language Server

[phpantom_lsp](https://github.com/PHPantom-dev/phpantom_lsp)

The binary lives at `/usr/local/bin/phpantom_lsp`
