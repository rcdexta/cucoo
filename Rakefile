require 'bundler/gem_tasks'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:cucumber) do |task|
  task.cucumber_opts = '--tags ~@fail'
end

task test: [:cucumber]
task default: :test