include_recipe 'selenium::default'

directory node['selenium']['server']['installpath']

remote_file File.join(node['selenium']['server']['installpath'], 'selenium-server-standalone.jar') do
  source "http://selenium.googlecode.com/files/selenium-server-standalone-#{node['selenium']['server']['version']}.jar"
  action :create
  mode 0644
end

directory "/var/run/#{new_resource.name}" do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

directory "/var/log/#{new_resource.name}" do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

template 'procfile.init' do
  path "/etc/init.d/#{new_resource.name}-#{type}"
  owner 'root'
  group 'root'
  mode '0755'
  variables ({
    :name => new_resource.name,
    :type => type,
    :current_path => ::File.join(new_resource.application.path, 'current'),
    :command => pf[type.to_s]
  })
end

