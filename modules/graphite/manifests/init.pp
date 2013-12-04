class graphite {
$miab_packages = ['graphite-web', 'carbon', 'whisper', 'httpd', 'django-tagging']

package { $miab_packages:
  ensure  => latest,
  }


service { 'carbon-cache':
  ensure    => running,
  enable    => true,
  hasstatus => true,
  require   => [Exec['change_owner_carbon'],File['/var/log/carbon-cache']],
  }

exec { 'change_owner_carbon':
  command => "/bin/sed -i -e  's/USER = carbon/USER = vagrant/' /etc/carbon/carbon.conf",
  onlyif  => "/bin/grep -c 'USER = carbon' /etc/carbon/carbon.conf",
  require => Package['carbon'],
  }

file { '/var/log/carbon-cache':
  owner   => 'vagrant',
  ensure  => directory,
  require => Package['carbon'],
  }

file {'/etc/carbon/storage-schemas.conf':
  owner   => 'vagrant',
  ensure  => present,
  replace => true,
  source  => '/tmp/vagrant-puppet/modules-0/graphite/files/storage-schemas.conf',
  require => Service['carbon-cache'],
  }

service { 'httpd':
  ensure    => running,
  enable    => true,
  hasstatus => true,
  require   => [Package['httpd'],Package['graphite-web']],
  }
}
