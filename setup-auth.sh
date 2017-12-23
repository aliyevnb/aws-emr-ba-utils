#!/bin/bash

KEY_HOME="/home/hadoop/.ssh"
PRIVATE_KEY_FILE="${KEY_HOME}/id_rsa"
PUBLIC_KEY_FILE="${KEY_HOME}/id_rsa.pub"
AUTH_KEY_FILE="${KEY_HOME}/authorized_keys"

put_private() {
	sudo /bin/cat <<-EOF >> "${PRIVATE_KEY_FILE}"
	-----BEGIN RSA PRIVATE KEY-----
	RSA PRIVATE MATERIAL GOES HERE
	-----END RSA PRIVATE KEY-----
	EOF
}

put_public() {
	sudo /bin/cat <<-EOF >> "${PUBLIC_KEY_FILE}"
	ssh-rsa RSA PUBLIC MATERIAL GOES HERE 
	EOF
}

set_public() {
	sudo /bin/cat <<-EOF >> "${AUTH_KEY_FILE}"
	ssh-rsa RSA PUBLIC MATERIAL GOES HERE 
	EOF
}
set -x

curl http://169.254.169.254/latest/user-data > /tmp/cluster_info.tmp
isMaster=$(jq -r ".isMaster" /tmp/cluster_info.tmp)

if [[ "${isMaster}" == "true" ]] ; then
    if [[ -d "${KEY_HOME}" ]] ; then
    	put_private
    	put_public
    	chmod -R 700 "${KEY_HOME}"
    else
    	mkdir -pv "${KEY_HOME}"
    	put_private
    	put_public
    	chmod -R 700 "${KEY_HOME}"
    fi
else
	if [[ -d "${KEY_HOME}" ]] ; then
        set_public
    else
        mkdir -pv "${KEY_HOME}"
        set_public
        chmod -R 700 "${KEY_HOME}"
    fi
fi
