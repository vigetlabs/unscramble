desc "Build and run the program in the specified languages/ directory"
task :run, :arg1 do |t, args|
  language_glob = args[:arg1] || '*'
  language_glob_desc = args[:arg1] || 'all languages'

  puts "Building #{language_glob_desc}..."
  Dir["languages/#{language_glob}/Rakefile"].sort.each do |path_to_rakefile|
    base_path, language, _ = path_to_rakefile.split('/')

    language_path = "#{base_path}/#{language}"
    puts "  * Entering directory '#{language_path}'"

    load path_to_rakefile

    begin
      clean_task_name = "#{language}:clean"
      print "    * Running task '#{clean_task_name}'... "

      clean_task = Rake::application.tasks.detect {|t| t.name == clean_task_name }

      if clean_task
        clean_task.invoke
        puts "done."
      else
        puts "not found."
      end

      build_task_name = "#{language}:build"
      print "    * Running task '#{build_task_name}'... "
      Rake::Task[build_task_name].invoke
      puts "done."

      ruby_exec = `which ruby`.chomp

      print "    * Running tests..."
      test_output = `LANGUAGE_PATH="./#{language_path}" "#{ruby_exec}" ./test/unscramble_test.rb`
      puts test_output
      if $?.success?
        puts "done."
      else
        puts "failed."
        # puts test_output
      end
    rescue => e
      puts "failed."
      puts "      #{e.message}"
    end

  end
end

task :default => :run
