# Puppetize the instructions on http://documentation.wazuh.com/en/latest/ossec_ruleset.html#automatic-installation
class ossec::wazuh_ruleset {

  file { '/var/cache/wget':
    ensure => directory
  } ->
  file { '/var/ossec/update':
    ensure => directory
  } ->
  file { '/var/ossec/update/ruleset':
    ensure => directory
  } ->
  exec { 'wget https://raw.githubusercontent.com/wazuh/ossec-rules/stable/ossec_ruleset.py && chmod 700 /var/ossec/update/ruleset/ossec_ruleset.py':
    user    => 'root',
    cwd     => '/var/ossec/update/ruleset/',
    creates => '/var/ossec/update/ruleset/ossec_ruleset.py',
    notify  => Exec['get ossec_ruleset']
  }

  exec { 'get ossec_ruleset':
    command     => '/var/ossec/update/ruleset/ossec_ruleset.py -s',
    cwd         => '/var/ossec/update/ruleset/',
    refreshonly => true
  }
}
