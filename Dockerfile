FROM openjdk:11-jdk-slim-bullseye
MAINTAINER Michael Edoror

RUN apt-get update && apt-get -y install --no-install-recommends wget curl unzip xz-utils python build-essential ssh git locales openssh-client libgtk2.0-0 \
                       libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb

ENV YARN_VERSION 1.22.4
ENV NODE_VERSION 16.14.2
ENV GRADLE_VERSION 7.2
ENV NVM_VERSION 0.39.1
ENV CYPRESS_VERSION 9.5.3

# Install nodejs via nvm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v${NVM_VERSION}/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

# Install gradle
ENV GRADLE_HOME /gradle-$GRADLE_VERSION
ENV PATH ${PATH}:$GRADLE_HOME/bin
RUN wget https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip && \
    unzip gradle-$GRADLE_VERSION-bin.zip && \
    rm -f gradle-$GRADLE_VERSION-bin.zip

RUN npm i --global yarn@$YARN_VERSION

# Install cypress
#RUN npm config -g set user $(whoami)
#RUN npm install -g "cypress@${CYPRESS_VERSION}"
#RUN cypress verify

RUN echo "whoami: $(whoami)" \
  && npm config -g set user $(whoami) \
  # command "id" should print:
  # uid=0(root) gid=0(root) groups=0(root)
  # which means the current user is root
  && id \
  && npm install -g "cypress@${CYPRESS_VERSION}" \
  && cypress verify
