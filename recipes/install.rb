#
# Cookbook Name:: memcached
# Recipe:: install
#
# Copyright 2012, ModCloth, Inc.
#
# Apache 2.0
#

include_recipe "smf::default"

case node[:platform]
when "solaris2", "smartos"
  execute "pkgin install memcached" do
    command "pkgin -y install memcached"
    not_if "pkgin list | grep E '^memcached'"
  end

  smf node.memcached.service_name do
    start_command "memcached -d -p %{config/port} -l %{config/listen_ip} -m %{config/memory} -c %{config/max_connections} -u %{config/user} -P %{config/pidfile}"
    start_timeout 30
    environment({
      "PATH" => "/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin",
      "EVENT_NOEVPORT" => "1",
      "EVENT_SHOW_METHOD" => "1"
    })
    property_groups({
      "config" => {
        "type" => "application",
        "user" => node.memcached.user,
        "port" => node.memcached.port,
        "listen_ip" => node.memcached.listen_ip,
        "pidfile" => node.memcached.pidfile,
        "memory" => node.memcached.memory,
        "max_connections" => node.memcached.max_connections
      }
    })
  end

  include_recipe "memcached::rbac"

  service node.memcached.service_name do
    action :enable
  end
end
