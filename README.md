# acme_sh

## Description

Install acme.sh LE client from [github.com/Neilpang/acme.sh](https://github.com/Neilpang/acme.sh).

This just installs the script/client only. You still need to do any certificate requests manually as well as yoru web server configurations.

## Reference

Needs two parameters:

 * `$acme_home` -
 The full path to install the acme.sh script into (overriding $HOME/.acme.sh).

 * `$accountemail` -
 Specify the email address to be used in Letsencrypt API communications.
 This email address will later receive certificate expiry warnings.

## Limitations

Only *explicitly* tested on RHEL/CentOS 6.

