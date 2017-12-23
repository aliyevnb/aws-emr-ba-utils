## aws-emr-ba-utils

By default, AWS EMR does not setup key based authentication between cluster nodes. This script will setup keybased authentication on a new EMR cluster between nodes using bootstrap actions.

This script will **not** generate ssh key, you have to do it before hand and supply script with it.

Generate script:
```
ssh-keygen -t rsa -b 2048
Generating public/private rsa key pair.
Enter file in which to save the key (/home/user/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/user/.ssh/id_rsa.
Your public key has been saved in /home/user/.ssh/id_rsa.pub.
```

Now `cat .ssh/id_rsa` key and add it to script. Include `-----BEGIN RSA PRIVATE KEY-----` and `-----END RSA PRIVATE KEY-----`. Same with the `id_rsa.pub` key, 

Please note, script will setup keys so you can access any node in withing cluster using **private** ip or hostname. Configuration is setup that you get from master node to any task or core nodes, **not** between core or task nodes.

Enjoy!
