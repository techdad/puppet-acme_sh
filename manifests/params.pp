# Parameters for class acme_sh
# see init.pp for more authors, license
# and more details
class acme_sh::params {
  $acme_source         = 'https://github.com/acmesh-official/acme.sh'
  $acme_repo_path      = '/opt/acme_repo'
  $acme_home           = '/opt/acme'
  $acme_certhome       = $acme_home
  $acme_accountemail   = undef
  $acme_version        = 'master'
  $manage_dependencies = false
  $acme_cron_enable    = true
}

