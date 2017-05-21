FROM debian:jessie
ENV DEBIAN_FRONTEND noninteractive

RUN useradd git -m -u 2222

RUN apt-get update \
&& apt-get install -y --no-install-recommends git perl openssh-server apache2-utils

RUN git clone git://github.com/sitaramc/gitolite /usr/local/src/gitolite \
&& /usr/local/src/gitolite/install -to /usr/local/bin

RUN sed -i 's/AcceptEnv/# \0/' /etc/ssh/sshd_config
RUN mkdir /var/run/sshd

COPY gitolite.rc /home/git/.gitolite.rc
COPY run.sh /run.sh
COPY admin.pub /home/git/admin.pub
RUN chown git: /home/git/admin.pub

CMD ["/run.sh"]
