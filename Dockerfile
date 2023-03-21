FROM node:13
ENV YARN_VERSION=1.22.19
RUN curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version ${YARN_VERSION}

