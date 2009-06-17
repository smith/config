# Tasks to install vim configuration
require 'fileutils'
include FileUtils

# Are we on windows?
def windows?
  !ENV["windir"].nil?
end

# Link a file in the config directory to one in the home directory
def make_link(file, home_file)
  file = File.join(Dir.getwd, file)
  home_file = File.join(ENV["HOME"], home_file)
  rm_rf(home_file) unless File.symlink?(home_file)
  ln_s(file, home_file, :force => true)
end

task :default => [:install]

desc "Install configuration files"
task :install do
  rc = "vimrc"
  folder = "vimfiles"
  print "This operation will remove any existing Vim configuration. Continue? "
  if gets[0].chr.downcase == "y"
    if windows?
      puts "This doesn't do anything for windows yet"
    else
      install_rc = ".vimrc"
      install_folder = ".vim"

      make_link(rc, install_rc)
      make_link(folder, install_folder)
    end
  else
    puts "Exiting with no updates."
    exit
  end
end

