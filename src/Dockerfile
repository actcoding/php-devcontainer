ARG PHP_VERSION


FROM rust:1-slim-bookworm AS phpantom_lsp

ARG phpantom_lsp_version=0.11.1

RUN apt-get update && \
    apt-get install -y \
        curl \
    && \
    curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

RUN cargo binstall --no-confirm phpantom_lsp


FROM php:${PHP_VERSION}-bookworm

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/install-php-extensions
ADD --chmod=0755 https://github.com/php/pie/releases/latest/download/pie.phar /usr/local/bin/pie

COPY rootfs /
COPY --from=phpantom_lsp /usr/local/cargo/bin/phpantom_lsp /usr/local/bin/phpantom_lsp

RUN apt-get update && \
    apt-get -y install \
        curl \
        wget \
        jq \
        git \
        p7zip-full \
        sudo \
        zsh \
        locales \
        nano \
    && \
    locale-gen

RUN pie install \
        xdebug/xdebug \
        phpredis/phpredis \
    && \
    install-php-extensions \
        pgsql \
        pdo_pgsql \
        opcache \
        pcntl \
        zip \
        intl \
        gd \
    && \
    mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini" && \
    curl -sSL https://getcomposer.org/installer | php && \
    chmod +x composer.phar && \
    mv composer.phar /usr/local/bin/composer

RUN groupadd -g 1001 vscode && \
    useradd -s /bin/zsh -m -u 1001 -g vscode vscode && \
    echo vscode ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/vscode && \
    chmod 0440 /etc/sudoers.d/vscode

USER vscode

RUN curl --proto '=https' --tlsv1.3 -LsSf https://starship.rs/install.sh | sh -s -- --yes && \
    curl --proto '=https' --tlsv1.3 -LsSf https://github.com/atuinsh/atuin/releases/latest/download/atuin-installer.sh | ATUIN_NO_MODIFY_PATH=1 sh && \
    mv ${HOME}/.atuin/bin/* "${HOME}/.local/bin" && \
    rm -rf "${HOME}/.atuin" && \
    mkdir -p "${HOME}/.cache" "${HOME}/.local"

VOLUME [ "/home/vscode/.cache", "/home/vscode/.local" ]
