FROM yukinying/chrome-headless

WORKDIR /usr/src/app
ENV CHROME_BIN=/chrome/headless_shell
RUN apt-get update && \
    apt-get install -y curl build-essential && \
    curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get install -y --no-install-recommends \
    nodejs \
    yarn \
    git \
    && rm -rf /var/lib/apt/lists/*

CMD npm test
