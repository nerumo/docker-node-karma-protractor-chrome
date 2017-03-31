FROM buildpack-deps:jessie

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get install -y --no-install-recommends \
    nodejs \
    git \
    xvfb \
    chromium \
    libgconf-2-4 \
    openjdk-7-jre-headless \
    yarn \
    && rm -rf /var/lib/apt/lists/*

ENV DISPLAY :99
ENV CHROME_BIN /usr/bin/chromium
CMD [ "node" ]
