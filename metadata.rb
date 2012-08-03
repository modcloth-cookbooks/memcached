maintainer       "ModCloth, Inc."
maintainer_email "ops@modcloth.com"
license          "Apache 2.0"
description      "Installs/Configures memcached"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.4"

depends 'smf'

%w(solaris2 smartos).each do |os|
  supports os
end

attribute "memcached/service_name",
  :display_name => "Memcached service name",
  :description  => "Name of service in SMF. Defaults to memcachedx.",
  :type         => "string",
  :required     => "optional"

attribute "memcached/user",
  :display_name => "Memcached user",
  :description  => "User to run memcached as. Defaults to memcached",
  :type         => "string",
  :required     => "optional"

attribute "memcached/users",
  :display_name => "Memcached users",
  :description  => "Users who can manage memcached in SMF",
  :type         => "array",
  :required     => "optional"

attribute "memcached/port",
  :display_name => "Memcached port",
  :description  => "Memcached port. Defaults to 11211",
  :type         => "string",
  :required     => "optional"

attribute "memcached/listen_ip",
  :display_name => "Memcached listen IP",
  :description  => "IP on which Memcached listens. Set to 0.0.0.0 to listen on all interfaces.",
  :type         => "string",
  :required     => "recommended"

attribute "memcached/pidfile",
  :display_name => "Memcached pidfile",
  :description  => "Full path to memcached pidfile. Defaults to /var/run/memcached.pid",
  :type         => "string",
  :required     => "optional"

attribute "memcached/memory",
  :display_name => "Memcached max memory",
  :description  => "Memory to allocate to memcached. Defaults to 1024",
  :type         => "string",
  :required     => "optional"

attribute "memcached/max_connections",
  :display_name => "Memcached max connections",
  :description  => "Maximum connections to allow to memcached. Defaults to 1024",
  :type         => "string",
  :required     => "optional"
