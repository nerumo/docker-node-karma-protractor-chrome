FROM yukinying/chrome-headless

WORKDIR /usr/src/app
ENV CHROME_BIN=/chrome/headless_shell
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    add-apt-repository -y ppa:webupd8team/java && \ 
    apt-get update && \
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
    oracle-java8-installer \
    lib32stdc++6 lib32z1 && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk8-installer

# install cordova
RUN npm i -g cordova@5.1.1 npm@5.0.3

RUN curl http://dl.google.com/android/android-sdk_r24.2-linux.tgz | tar xz -C /usr/local/
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# update and accept licences
RUN ( sleep 5 && while [ 1 ]; do sleep 1; echo y; done ) | /usr/local/android-sdk-linux/tools/android update sdk --no-ui -a --filter platform-tool,build-tools-22.0.1,android-22

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV GRADLE_USER_HOME /src/gradle

CMD npm test
