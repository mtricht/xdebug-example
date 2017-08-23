Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.network :forwarded_port, guest: 80, host: 8001, auto_correct: true
  config.vm.provision :shell, :path => "bootstrap.sh"
end
