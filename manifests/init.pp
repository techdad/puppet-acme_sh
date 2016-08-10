# Class: acme_sh
# ===========================
#
# Install acme.sh LE client from https://github.com/Neilpang/acme.sh
#
# Parameters
# ----------
#
# * `$acme_home`
# The full path to install the acme.sh script into (overriding $HOME/.acme.sh).
#
# * `$acme_accountemail`
# Specify the email address to be used in Letsencrypt API communications.
# This email address will later receive certificate expiry warnings.
#
# Authors
# -------
#
# Daniel Shaw <daniel@techdad.xyz>
#
# License
# -------
#
# Apache 2.0
#
class acme_sh {

  # install packages that are dependencies
  if ! defined(Package['git']) {
    package { 'git':
      ensure => present,
    }
  }

  if ! defined(Package['nc']) {
    package { 'nc':
      ensure => present,
    }
  }

  # clone acme.sh from git if not there at all
  exec { 'acme_sh::git clone':
    creates => '/tmp/.acme.sh',
    command => 'git clone https://github.com/Neilpang/acme.sh.git /tmp/.acme.sh || (rmdir /tmp/.acme.sh && exit 1)',
    path    => ['/bin', '/usr/bin'],
    require => Package['git'],
  }

  # update (pull) from git if already there
  exec { 'acme_sh::git pull':
    onlyif  => 'test -f /tmp/.acme.sh/acme.sh',
    command => 'git pull --rebase --stat origin master',
    path    => ['/bin', '/usr/bin'],
    cwd     => '/tmp/.acme.sh',
    require => Package['git'],
    notify  => Exec['acme_sh::self-install'],
  }

  # install/upgrade the script from the git source
  exec { 'acme_sh::self-install':
    command     => "/bin/sh ./acme.sh --install  --home ${acme_home} --accountemail \"${acme_accountemail}\"",
    path        => ['/bin', '/usr/bin'],
    cwd         => '/tmp/.acme.sh',
    refreshonly => true,
  }

}
