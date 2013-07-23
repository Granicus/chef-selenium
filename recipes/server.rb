include_recipe 'selenium::default'

directory node['selenium']['server']['installpath']

remote_file File.join(node['selenium']['server']['installpath'], 'selenium-server-standalone.jar') do
  source "http://selenium.googlecode.com/files/selenium-server-standalone-#{node['selenium']['server']['version']}.jar"
  action :create
  mode 0644
end

directory "/var/run/selenium" do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

directory "/var/log/selenium" do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

template 'procfile.init' do
  path "/etc/init.d/selenium"
  owner 'root'
  group 'root'
  mode '0755'
end


template 'procfile.monitrc' do
  path "/etc/monit/conf.d/selenium.conf"
  owner 'root'
  group 'root'
  mode '0644'
end

