class snmpmibs {

file { '/usr/share/snmp/mibs':
  ensure  => present,
  replace => true,
  recurse => true,
  source  => '/tmp/vagrant-puppet/modules-0/snmpmibs/files/mibs',
  }
file { '/usr/share/snmp/snmp.conf':
  ensure  => present,
  replace => true,
  source  => '/tmp/vagrant-puppet/modules-0/snmpmibs/files/snmp.conf',
  }
}

