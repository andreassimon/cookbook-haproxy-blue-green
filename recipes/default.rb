#
# Cookbook Name:: haproxy-blue-green
# Recipe:: default
#
# Copyright 2014, Quagilis Andreas Simon
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

include_recipe "haproxy::default"

%w(blue green).each do |env|
  template "#{node['haproxy']['conf_dir']}/haproxy.#{env}.cfg" do
    source "haproxy.cfg.erb"
    owner "root"
    group "root"
    mode 00644
    notifies :reload, "service[haproxy]"
    variables(
      :active_zone => env,
      :blue_http_port => node["tomcat"]["blue"]["http_port"],
      :green_http_port => node["tomcat"]["green"]["http_port"],
      :defaults_options => haproxy_defaults_options,
      :defaults_timeouts => haproxy_defaults_timeouts
    )
  end
end

template "#{node['haproxy']['conf_dir']}/haproxy.cfg" do
  action :nothing
end

link "#{node['haproxy']['conf_dir']}/haproxy.cfg" do
  to './haproxy.blue.cfg'
  not_if "readlink #{node['haproxy']['conf_dir']}/haproxy.cfg"
  notifies :reload, "service[haproxy]"
  action :create
end

