require 'rspec/core/rake_task'

desc 'Run that fun!'
RSpec::Core::RakeTask.new(:spec)

namespace :redis do
  desc 'Start Redis for development'
  task :start do
    system 'redis-server /usr/local/etc/redis.conf'
  end
end

namespace :http_parrot do
  desc 'Start HTTPParrot for development'
  task :start do
    system 'shotgun --host 192.168.126.51 http_parrot_app.rb'
  end
end

task :default => :spec
multitask :start => ['redis:start', 'http_parrot:start']
