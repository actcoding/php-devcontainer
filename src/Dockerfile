ARG PHP_VERSION

FROM php:${PHP_VERSION}-bookworm

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

COPY rootfs /

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

RUN install-php-extensions \
        xdebug \
        pgsql \
        pdo_pgsql \
        redis \
        opcache \
        pcntl \
        zip \
        intl \
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

RUN curl https://frankenphp.dev/install.sh | BIN_DIR="${HOME}/bin" sh && \
    curl --proto '=https' --tlsv1.2 -LsSf https://starship.rs/install.sh | sh -s -- --yes && \
    curl --proto '=https' --tlsv1.2 -LsSf https://github.com/atuinsh/atuin/releases/latest/download/atuin-installer.sh | ATUIN_NO_MODIFY_PATH=1 sh && \
    mv ${HOME}/.atuin/bin/* "${HOME}/bin" && \
    rm -rf "${HOME}/.atuin" && \
    mkdir -p "${HOME}/.cache" "${HOME}/.local"

VOLUME [ "/home/vscode/.cache", "/home/vscode/.local" ]
