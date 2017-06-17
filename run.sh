#!/usr/bin/env bash
set -x
chown -R git: /home/git/repositories
chown -R git: /home/git/data
chown -R git: /home/git/.ssh

touch /home/git/data/htpasswd

if [ ! -e /home/git/.gitolite ]; then
  su - git -c "gitolite setup -pk /home/git/admin.pub"
  su - git -c "mkdir -p /home/git/.gitolite/local/hooks/repo-specific"
fi

su - git -c "gitolite setup"
su - git -c "gitolite trigger POST_CREATE"

/usr/sbin/sshd -D -e
