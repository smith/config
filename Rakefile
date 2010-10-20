# Tasks to install vim configuration
require 'fileutils'
include FileUtils

def windows?
  !ENV["windir"].nil?
end

task :default => [:install]

desc "Install configuration files"
task :install => [:update_vendor] do
  print "This operation will remove any existing Vim configuration. Continue? "
  if STDIN.gets[0].chr.downcase == "y"
    map = { "vimrc"    => windows? ? "_vimrc"   : ".vimrc",
            "vimfiles" => windows? ? "vimfiles" : ".vim" }

    map.each_pair do |here, there|
      home = ENV["HOME"]
      raise RuntimeError.new("Could not find a home directory. Make sure the HOME environment variable is set. Exiting with no updates") if !home

      here = File.join(Dir.getwd, here)
      there = File.join(home, there)

      begin
        rm_rf(there)
        ln_s(here, there, :force => true)
      rescue NotImplementedError => e
        File.directory?(here) ? cp_r(here, home) : cp(here, there)
      end
    end
    puts "Installed Vim configuration."
  else
    puts "Exiting with no updates."
  end
end

desc "Install non-vim config files"
task :install_extra do
  unless windows?
    Dir["extra/**/*"].each do |f|
      unless File.directory?(f)
        dest = File.join(ENV["HOME"], ".#{f.gsub(/^extra\//, "")}")
        ln_s(File.expand_path(f), dest, :force => true)
      end
    end
  end
end

desc "Update external modules"
task :update_vendor do
  puts "Updating submodules..."
  puts `git submodule init`
  puts `git submodule update`
end

desc "Update vim-ruby"
task :update_vim_ruby do
  path = File.join(File.dirname(File.expand_path(__FILE__)), "vimfiles")
  puts `gem install vim-ruby`
  puts `vim-ruby-install.rb -d #{path}`
end
