# Rakefile for dotfiles

require "pathname"

IGNORE_FILES = %w(.git .gitignore .gitmodules).freeze

desc "Create symlinks."
task :setup do
  dotfiles.each {|dotfile|
    symlink = symlink_path(dotfile)
    FileUtils.rm symlink, verbose: true if symlink.exist?
    FileUtils.ln_s dotfile, symlink, verbose: true
  }
end

desc "Remove symlinks."
task :prune do
  dotfiles.each {|dotfiles| FileUtils.rm symlink_path(dotfiles), verbose: true }
end

desc "Fonts install"
task :fonts_install do
  fonts.each {|font|
    dest = font_path(font)
    FileUtils.rm dest, verbose: true if dest.exist?
    FileUtils.cp font, dest, preserve: true, verbose: true
  }

  unless osx?
    cmd = "fc-cache -vf ~/.fonts"
    puts cmd
    system(cmd)
  end
end

task :default => [:setup]

private

def home
  Pathname.new(File.expand_path("~"))
end

def dotfiles_home
  home.join("dotfiles")
end

def dotfiles(ignore_files = IGNORE_FILES)
  ignores = ignore_files.map {|file| dotfiles_home.join(file) }
  Pathname.glob(dotfiles_home.join(".[a-z]*")) - ignores
end

def fonts
  Pathname.glob(dotfiles_home.join("fonts").join("*"))
end

def symlink_path(file)
  home.join(file.basename)
end

def font_path(file)
  osx? ? home.join("Library/Fonts").join(file) : home.join(".fonts").join(file)
end

def osx?
  RUBY_PLATFORM.downcase.include?("darwin")
end

