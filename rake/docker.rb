require_relative 'config'

@local_repository = ENV["local_repository"] || @local_repository || 'local'
@remote_repository = ENV["remote_repository"] || @remote_repository
@docker_build_args = ENV["docker_build_args"] || @docker_build_args

@distribution = ENV["distribution"] || @distribution || 'stretch'
@image_date = Time.now.strftime("%Y%m%dT%H%M%S")

desc "build docker image"
task :build do
  base_name = "debian-#{@distribution}-#{@name}"
  sh "docker build --build-arg LOCAL_REPOSITORY=#{@local_repository} --build-arg DISTRIBUTION=#{@distribution} #{@docker_build_args} -t #{@local_repository}:#{base_name}-latest -t #{@local_repository}:#{base_name}-#{@image_date} ."
end

desc "push image to remote repository"
task :push do
  base_name = "debian-#{@distribution}-#{@name}"
	sh "docker tag #{@local_repository}:#{base_name}-#{@image_date} #{@remote_repository}:#{base_name}-#{@image_date}"
	sh "docker push #{@remote_repository}:#{base_name}-#{@image_date}"
	sh "docker tag #{@local_repository}:#{base_name}-latest #{@remote_repository}:#{base_name}-latest"
	sh "docker push #{@remote_repository}:#{base_name}-latest"
end

if File.exist? "resources.yml"
  desc "get necessary resources"
  task :get do
    sh "ansible-playbook ../get-resources.yml -e @resources.yml -e working_directory=#{Dir.pwd}"
  end
end

desc "Run default tasks for distribution stretch"
task :stretch do
  @distribution = "stretch"
  Rake::Task[:default].invoke
end

desc "Run default tasks for distribution buster"
task :buster do
  @distribution = "buster"
  Rake::Task[:default].invoke
end

task default: [:build, :push]
