Vagrant.configure("2") do |config|

  # Box base (Ubuntu Server)
  config.vm.box = "ubuntu/jammy64"

  # VM 1 - Hadoop
  config.vm.define "hadoop-node" do |hadoop|
    hadoop.vm.hostname = "hadoop-node"

    hadoop.vm.provider "virtualbox" do |vb|
      vb.name = "hadoop-node"
      vb.memory = 2048
      vb.cpus = 2
    end

    hadoop.vm.network "private_network", ip: "192.168.56.10"
  end

  # VM 2 - Trino
  config.vm.define "trino-node" do |trino|
    trino.vm.hostname = "trino-node"

    trino.vm.provider "virtualbox" do |vb|
      vb.name = "trino-node"
      vb.memory = 2048
      vb.cpus = 2
    end

    trino.vm.network "private_network", ip: "192.168.56.11"
  end

end