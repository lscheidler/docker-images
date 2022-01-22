require_relative 'config'

def image name, &block
  @namespace = namespace name do |namespace|
    require_relative 'container'
  
    @name = name

    @override[:all] and @override[:all].each do |override_key, override_value|
      instance_variable_set "@#{override_key}", override_value
    end

    @override[@name] and @override[@name].each do |override_key, override_value|
      instance_variable_set "@#{override_key}", override_value
    end
  
    yield if block
  end
  
  @namespace.tasks.each do |task|
    desc "[#{name}] " + task.full_comment if task.full_comment
    task "#{task.name[/^[^:]*:(.*)/, 1]}" => [task.name]
  end
end

def distribution suite, type="debian"
  desc "update images for #{suite}"
  task suite => ["#{suite}:update"]

  desc "create base image for #{type}-#{suite}"
  task "base_image:#{suite}:create" do
    Dir.chdir("ansible-docker-base-image") do
      sh "rake distribution=#{suite} type=#{type}"
    end
  end

  desc "update base image for #{type}-#{suite}"
  task "base_image:#{suite}:update" do
    Dir.chdir("ansible-docker-update-image") do
      sh "rake distribution=#{suite} type=#{type}"
    end
  end

  desc "update images for #{type}-#{suite}"
  task "#{suite}:update" do
    @rake_parameters = "distribution=#{suite} type=#{type}"
    Rake::Task[:update].invoke
  end
end
