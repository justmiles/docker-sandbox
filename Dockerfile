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

COPY config /home/developer/.config/terminator/config

COPY entrypoint.sh /entrypoint.sh

RUN chown -R developer.developer /home/developer

USER developer

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || true

WORKDIR /home/developer

USER root

ENTRYPOINT ["/entrypoint.sh"]

CMD ["terminator"]
