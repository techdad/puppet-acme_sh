# acme_sh

## Description

Install acme.sh LE client from [github.com/Neilpang/acme.sh](https://github.com/Neilpang/acme.sh).

This just installs the script/client only. You still need to do any certificate requests manually as well as yoru web server configurations.

## Reference

Needs the following parameters:

 * `$acme_repo_path`
 The full path to clone the acme.sh git repository in order to install from.
 (default: '/opt/acme_repo')

 * `$acme_home` -
 The full path to install the acme.sh script into (overriding $HOME/.acme.sh).
 (default: '/opt/acme')

 * `$acme_certhome` -
 A customized dir to save the certs you issue.
 (default: $acme_home)

 * `$accountemail` -
 Specify the email address to be used in Letsencrypt API communications.
 This email address will later receive certificate expiry warnings.
 (default: undef)

 * `$acme_version` -
 The version/release of the acme git repository to clone.
 (default: 'master')

 * `$manage_dependencies`
 Boolean to specify whether or not to install the required package dependencies.
 (default: false)

## Limitations

Only *explicitly* tested on RHEL/CentOS 6 and Debian 7

