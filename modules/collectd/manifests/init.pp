
class collectd { $collectd_packages = ['collectd', 'collectd-snmp']
package { $collectd_packages:
  ensure  => latest,
  require => Yumrepo['collectd-base'],
  }
yumrepo { "collectd-base":
  baseurl  => 'http://10.224.130.162/rhel6/repo',
  enabled  => 1,
  gpgcheck => 0,
  }

class collectd_files {
file { '/etc/collectd.conf':
  ensure  => present,
  replace => true,
  source  => '/tmp/vagrant-puppet/modules-0/collectd/files/collectd.conf',
  }
file { '/etc/collectd.d':
  ensure  => present,
  replace => true,
  recurse => true,
  source  => '/tmp/vagrant-puppet/modules-0/collectd/files/collectd.d',
  }
file { '/usr/share/collectd/sfdc_types.db':
  ensure  => present,
  replace => true,
  source  => '/tmp/vagrant-puppet/modules-0/collectd/files/sfdc_types.db',
  }
 }
 include collectd::collectd_files

exec { 'change_owner_collectd':
  command => "/bin/sed -i -e  's/USER = collectd/USER = vagrant/' /etc/collectd.conf",
  onlyif  => "/bin/grep -c 'USER = collectd' /etc/collectd.conf",
  require => Package['collectd'],
  }

service { 'collectd':
  ensure    => running,
  enable    => true,
  hasstatus => true,
  require   => [Package['collectd'],Package['collectd-snmp'],Exec['change_owner_collectd'],Class['collectd_files'],Class['snmpmibs']],
  }
}
