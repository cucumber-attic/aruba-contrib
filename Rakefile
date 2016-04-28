$LOAD_PATH << File.expand_path('../', __FILE__)

require 'aruba/tasks/docker_helpers'

require 'bundler'
Bundler.setup

task :default => :test

desc 'Run the whole test suite. Any failure will stop rake going on'
task :test => %w(lint:travis lint:coding_guidelines lint:licenses test:rspec test:cucumber test:cucumber_wip)

namespace :test do
  desc 'Run cucumber tests'
  task :cucumber do
    sh 'cucumber'
  end

  desc 'Run cucumber tests which are "WORK IN PROGRESS" and are allowed to fail'
  task :cucumber_wip do
    sh 'cucumber -p wip'
  end

  desc 'Run rspec tests'
  task :rspec do
    sh 'rspec'
  end
end

namespace :lint do
  desc 'Lint our .travis.yml'
  task :travis do
    begin
      require 'travis/yaml'

      puts 'Linting .travis.yml ... No output is good!'
      Travis::Yaml.parse! File.read('.travis.yml')
    rescue LoadError => e
      $stderr.puts "You ruby is not supported for linting the .travis.yml: #{e.message}"
    end
  end

  desc 'Lint our code with "rubocop"'
  task :coding_guidelines do
    sh 'rubocop --fail-level E'
  end

  desc 'Check for relevant licenses in project'
  task :licenses do
    sh 'license_finder'
  end
end

namespace :rubygem do
  Bundler::GemHelper.install_tasks
end

namespace :docker do
  desc 'Build docker image'
  task :build, :cache, :version do |_, args|
    args.with_defaults(:version => 'latest')
    args.with_defaults(:cache => true)

    docker_compose_file = Aruba::DockerComposeFile.new(File.expand_path('../docker-compose.yml', __FILE__))
    docker_run_instance = Aruba::DockerRunInstance.new(docker_compose_file, :base)

    builder = Aruba::DockerBuildCommandLineBuilder.new(
      docker_run_instance,
      cache: args[:cache],
      version: args[:version]
    )

    sh builder.to_cli
  end

  desc 'Run docker container'
  task :run, :command do |_, args|
    docker_compose_file = Aruba::DockerComposeFile.new(File.expand_path('../docker-compose.yml', __FILE__))
    docker_run_instance = Aruba::DockerRunInstance.new(docker_compose_file, :base)

    builder = Aruba::DockerRunCommandLineBuilder.new(
      docker_run_instance,
      command: args[:command] || docker_run_instance.command,
    )

    sh builder.to_cli
  end
end
