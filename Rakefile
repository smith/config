# Tasks to install vim configuration
require 'fileutils'
include FileUtils

def windows?
  !ENV["windir"].nil?
end

def home
  ENV['HOME']
end

task :default => [:install]
desc "Install configuration files"
task :install => ['install:default']

namespace :install do
  task :default => [:update_vendor] do
    print "This operation will remove any existing Vim configuration. Continue? "
    if STDIN.gets[0].chr.downcase == "y"
      map = { "vimrc"    => windows? ? "_vimrc"   : ".vimrc",
              "vimfiles" => windows? ? "vimfiles" : ".vim" }

      map.each_pair do |here, there|
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
  task :extra do
    unless windows?
      `git submodule update extra/*`
      Dir["extra/**/*"].each do |f|
        dest = File.join(home, ".#{f.gsub(/^extra\//, "")}")
        if File.directory?(f)
          mkdir_p(dest)
        else
          ln_s(File.expand_path(f), dest, :force => true)
        end
      end
      # symlink everything in ~/.bin to ~/bin
      Dir[File.join(home, ".bin/*")].each do |bin|
        ln_s(File.expand_path(bin),
             File.join(home, 'bin', File.basename(bin)), :force => true)
      end
    end
  end
end

task :update_vendor do
  puts "Updating submodules..."
  puts `git submodule init`
  puts `git submodule update`
end
