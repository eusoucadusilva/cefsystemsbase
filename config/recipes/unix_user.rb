set_default(:deployer_password) { Capistrano::CLI.password_prompt "UNIX password for user #{deploy_user}: " }
set_default(:dont_create, "false") # flag

namespace :user_unix do

  desc "Create user for deployment"
  task :create_user do
    close_sessions
    set :deploy_user, user  # saves the content of user variable, so it can be restored later
    set :user, root_user    # sets user to root for first login

    run "sed -n /#{deploy_user}/{p} /etc/passwd" do |channel, stream, data|
      if data.match("#{deploy_user}")   # checks if deploy_user already exists (for multiple recipe invocation)
        set :dont_create, "true"
      end
    end

    puts "Dont_create is #{dont_create}"

    if dont_create == "false"
      run "#{sudo} adduser #{deploy_user} --ingroup admin" do |channel, stream, data|
        channel.send_data("#{deployer_password}\n") if data =~ /UNIX password/
        # setting UNIX prompt data to default
        channel.send_data("\n") if data =~ /(Full Name|Room Number|Work Phone|Home Phone|Other|information correct)/
      end
      puts "User #{deploy_user} created!"
    end
  end
  #before "deploy:install", "system_user:create_user" # just reference: already set in base.rb
end
