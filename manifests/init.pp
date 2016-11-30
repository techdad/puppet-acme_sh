# Class: acme_sh
# ===========================
#
# Install acme.sh LE client from https://github.com/Neilpang/acme.sh
#
# Parameters
# ----------
#
# * `$acme_repo_path`
# The full path to clone the acme.sh git repository in order to install from.
#
# * `$acme_home`
# The full path to install the acme.sh script into (overriding $HOME/.acme.sh).
#
# * `$acme_certhome`
# A customized dir to save the certs you issue. By default, it saves the certs in $acme_home
#
# * `$acme_accountemail`
# Specify the email address to be used in Letsencrypt API communications.
# This email address will later receive certificate expiry warnings.
#
# * `$manage_dependencies`
# Boolean to specify whether or not to install the required package dependencies
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
class acme_sh (
  $acme_repo_path      = $acme_sh::params::acme_repo_path,
  $acme_home           = $acme_sh::params::acme_home,
  $acme_certhome       = $acme_sh::params::acme_certhome,
  $acme_accountemail   = $acme_sh::params::acme_accountemail,
  $acme_version        = $acme_sh::params::acme_version,
  $manage_dependencies = $acme_sh::params::manage_dependencies,
  ) inherits acme_sh::params {

  validate_string($acme_repo_path, $acme_home, $acme_certhome, $acme_accountemail)
  validate_bool($manage_dependencies)

  if $manage_dependencies {
    $dependencies = ['git']
    ensure_packages($dependencies)
    Package[$dependencies] -> Vcsrepo[$acme_repo_path]
  }

  vcsrepo {$acme_repo_path:
    ensure   => present,
    provider => git,
    source   => 'https://github.com/Neilpang/acme.sh.git',
    revision => $acme_version,
    notify   => Exec['acme_sh::self-install'],
  }

  exec { 'acme_sh::self-install':
    command => "/bin/sh ./acme.sh --install --home ${acme_home} --certhome ${acme_certhome} --accountemail \"${acme_accountemail}\"",
    path    => ['/bin', '/usr/bin'],
    cwd     => $acme_repo_path,
    creates => $acme_home,
  }

}
