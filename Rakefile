require_relative "rake/helper"

task default: [:stretch]

distribution :stretch
distribution :buster

require_relative "images"

dependencies = {}
images.each do |image_data|
  directory = image_data[:directory]
  image_name = image_data[:name]
  parameter = image_data[:parameter]

  dependencies["update"] ||= {comment: "update images", tasks: []}
  dependencies["update"][:tasks] << image_name
  desc "[#{image_name}] update docker image"
  task "#{image_name}" do
    Dir.chdir(directory) do
      sh "rake #{parameter}"
    end
  end

  dependencies["build"] ||= {comment: "build docker images", tasks: []}
  dependencies["build"][:tasks] << "#{image_name}:build"
  desc "[#{image_name}] build docker image"
  task "#{image_name}:build" do
    Dir.chdir(directory) do
      sh "rake build #{parameter}"
    end
  end

  dependencies["push"] ||= {comment: "push docker images", tasks: []}
  dependencies["push"][:tasks] << "#{image_name}:push"
  desc "[#{image_name}] push docker image"
  task "#{image_name}:push" do
    Dir.chdir(directory) do
      sh "rake push #{parameter}"
    end
  end

  if File.exist? File.join(directory, "resources.yml")
    dependencies["get"] ||= {comment: "get necessary resources", tasks: []}
    dependencies["get"][:tasks] << "#{image_name}:get"
    desc "[#{image_name}] get necessary resources"
    task "#{image_name}:get" do
      Dir.chdir(directory) do
        sh "ansible-playbook ../get-resources.yml -e @resources.yml -e working_directory=#{Dir.pwd}"
      end
    end
  end
end

dependencies.each do |name, task_dependencies|
  desc task_dependencies[:comment] if task_dependencies[:comment]
  task name => task_dependencies[:tasks]
  #task name do
  #  puts task_dependencies[:tasks]
  #end
end
