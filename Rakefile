# Tasks to install vim configuration
require 'fileutils'
include FileUtils

is_windows = !ENV["windir"].nil?

task :default => [:install]

desc "Install configuration files"
task :install do
  print "This operation will remove any existing Vim configuration. Continue? "
  if STDIN.gets[0].chr.downcase == "y"
    map = { "vimrc"    => is_windows ? "_vimrc"   : ".vimrc",
            "vimfiles" => is_windows ? "vimfiles" : ".vim" }

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
  if !is_windows
    Dir.glob("extra/*").each do |f|
      dest = File.join(ENV["HOME"], ".#{File.basename(f)}")
      ln_s(File.expand_path(f), dest, :force => true)
    end
  end
end
