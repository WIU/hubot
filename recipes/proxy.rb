proxychains_location = "/opt/proxychains-ng"

git proxychains_location do
  repository "https://github.com/haad/proxychains.git"
  action :checkout
  notifies :run, "execute[build and install proxychains]", :immediately
end

execute "build and install proxychains" do
  cwd proxychains_location
  code <<-EOH
    ./configure && make && make install
  EOH
  action :nothing
end

template "/etc/proxychains.conf" do
  source "proxychains.conf"
  mode 6440
end
