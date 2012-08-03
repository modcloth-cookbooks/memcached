#
# Cookbook Name:: memcached
# Recipe:: install_rbac
#
# Copyright 2012, ModCloth, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "memcached::install"
users = node.memcached.users

#RBAC control of memcached by user defined for particular service
users.each do |user|
  if user != "memcached" && user != "root"
    memcached_rbac = rbac node.memcached.service_name

    ruby_block "Install role base authorization for #{user} to control memcached" do
      block do
        Chef::Resource::Rbac.definitions << node.memcached.service_name
        memcached_rbac.run_action(:define)

        Chef::Resource::Rbac.permissions[user] ||= []
        Chef::Resource::Rbac.permissions[user] << node.memcached.service_name
        notifies :apply, memcached_rbac
      end
      only_if "id -u #{user}"
    end

    smf node.memcached.service_name do
      action :redefine
    end
  end
end
