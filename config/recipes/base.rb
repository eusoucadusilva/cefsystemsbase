def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

def close_sessions  # method is needed when changing user from root to deployer. Sessions need to close
  sessions.values.each { |session| session.close }
  sessions.clear
end

namespace :deploy do
  desc "Install everything onto the server"
  task :install do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install python-software-properties"
    run "#{sudo} locale-gen pt_BR pt_BR.UTF-8"
    run "#{sudo} dpkg-reconfigure locales"
  end
end
