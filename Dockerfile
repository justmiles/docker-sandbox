FROM phusion/baseimage:0.9.17

ENV USER_ID=999
ENV GROUP_ID=999

RUN apt-get update && apt-get install -y terminator wget git zsh

RUN groupadd developer --gid $USER_ID  && \
  useradd developer --gid $GROUP_ID --uid $USER_ID --home-dir /home/developer --create-home --shell /usr/bin/zsh && \
  usermod -a -G sudo developer && \
  echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
  chmod 0440 /etc/sudoers.d/developer && \
  chown ${uid}:${gid} -R /home/developer

RUN mkdir -p /home/developer/.config/terminator

COPY terminator_config /home/developer/.config/terminator/config

COPY entrypoint.sh /entrypoint.sh

RUN chown -R developer.developer /home/developer

ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.11.2
ENV DOCKER_SHA256 8c2e0c35e3cda11706f54b2d46c2521a6e9026a7b13c7d4b8ae1f3a706fc55e1

RUN set -e \
  && curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
  && echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
  && tar -xzvf docker.tgz \
  && mv docker/* /usr/local/bin/ \
  && rmdir docker \
  && rm docker.tgz \
  && docker -v
  
USER developer

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || true

RUN touch ~/.bashrc \
  && curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash

RUN ["/bin/bash", "-c", "source ~/.nvm/nvm.sh && nvm install --lts"]

WORKDIR /home/developer

USER root

ENTRYPOINT ["/entrypoint.sh"]

CMD ["terminator"]
