#!/bin/sh

###ssh-agent bash
#ssh-add ~/.ssh/id_rsa

if [ -z "$1" ]; then
  echo "Usage: $0 adminname"
  exit 1
fi

d=$(date '+%Y.%m.%d_%H:%M')
ANSIBLE_FORCE_COLOR=true  ansible-playbook -u $1 -k -i inventory/hosts site.yml -b --diff 2>&1 | tee "./deploy-$d.log"

sed -i -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" "./deploy-$d.log"
