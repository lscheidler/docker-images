require_relative 'config'

case @backend
when :buildah
  if @buildah_type and @buildah_type == :rootless
    container_cmd = 'buildah'
  else
    container_cmd = 'sudo buildah'
  end
  container_cmd_build = "#{container_cmd} bud"
else
  container_cmd = 'docker'
  container_cmd_build = "#{container_cmd} build"
end

@local_repository = ENV["local_repository"] || @local_repository || 'local'
@remote_repository = ENV["remote_repository"] || @remote_repository
@container_build_args = ENV["container_build_args"] || @container_build_args

@distribution = ENV["distribution"] || @distribution || 'bookworm'
@type = ENV["type"] || @type || 'debian'
@image_date = Time.now.strftime("%Y%m%dT%H%M%S")

desc "build #{container_cmd} image"
task :build do
  base_name = "#{@type}-#{@distribution}-#{@name}"
  sh "#{container_cmd_build} --build-arg LOCAL_REPOSITORY=#{@local_repository} --build-arg DISTRIBUTION=#{@distribution} #{@container_build_args} -t #{@local_repository}:#{base_name}-latest -t #{@local_repository}:#{base_name}-#{@image_date} ."
end

desc "push image to remote repository"
task :push do
  base_name = "#{@type}-#{@distribution}-#{@name}"
  if @remote_repository
    sh "#{container_cmd} tag #{@local_repository}:#{base_name}-#{@image_date} #{@remote_repository}:#{base_name}-#{@image_date}"
    sh "#{container_cmd} push #{@remote_repository}:#{base_name}-#{@image_date}"
    sh "#{container_cmd} tag #{@local_repository}:#{base_name}-latest #{@remote_repository}:#{base_name}-latest"
    sh "#{container_cmd} push #{@remote_repository}:#{base_name}-latest"
  else
    warn 'No remote repository set.'
  end
end

if File.exist? "resources.yml"
  desc "get necessary resources"
  task :get do
    sh "ansible-playbook ../get-resources.yml -e @resources.yml -e working_directory=#{Dir.pwd}"
  end

  desc "delete dist directory"
  task :clean do
    rm_rf "dist/"
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
