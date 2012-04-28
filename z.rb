#!/usr/bin/env ruby


require 'ruby-debug'
require 'optparse'
require 'fileutils'

$z_file = Dir.home + "/.z_shortcuts"
FileUtils.touch($z_file)
opts = OptionParser.new

def deleteFromFile(shortcut)
  entryHash = Hash[File.open($z_file, 'r').read.split.map{|x| x.split("=")}]
  entryHash.delete(shortcut)
  File.open($z_file, 'w') {|f| f.write(entryHash.map{|x| x.join"="}.join("\n") + "\n")}
end

opts.on('-h', '--help') do |x|
  puts "echo \'#{opts}\'"
end

opts.on('-a shortcut [path_to]', "Adds shortcut with name $shortcut, with the optional argument path_to, defaulting to $PWD") do |shortcut, path_to|
  if path_to.nil?
    path_to = Dir.getwd
  end
  deleteFromFile(shortcut)
  File.open($z_file, 'a+') {|f| f.write("#{shortcut}=#{path_to} \n")}
end

opts.on('-d shortcut', "Deletes shortcut named $shortcut from the list of shortcuts") do |shortcut|
  deleteFromFile(shortcut)
end

opts.on('-l', "Lists current shortcuts") do
entryHash = File.open($z_file, 'r').read
  puts "echo \'#{entryHash}\'"
end

opts.on('-e', "Export the list into a format which can be used for emacs bookmarks")

opts.parse!ARGV

def findEntry(shortcut)
  entryHash = Hash[File.open($z_file, 'r').read.split.map{|x| x.split("=")}]
  return entryHash[shortcut]
end

def normalHop(shortcut)
  place_to_hop = findEntry(shortcut)
  if place_to_hop.nil?
    return
  end
  puts "cd #{place_to_hop}"
end

normalHop(ARGV.first)
