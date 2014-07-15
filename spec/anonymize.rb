require 'fileutils'
require 'tempfile'

filename = ARGV[0]

unless filename
  puts "usage: anonymize.rb <filename>"
else
  tempfile_name = filename + ".temp"
  t_file = File.new(tempfile_name,"w")
 # t_file = Tempfile.new(tempfile_name)
  File.open(filename, 'r') do |f|
      f.each_line do |line|
        newline = line
        newline = newline.gsub(/B[abr]+ K[lein]+/i,"Donald Duck")
        newline = newline.gsub(/htw-berlin.de/i,"uni-entenhausen.de")
        newline = newline.gsub(/s05\d+/i,"student001")

        t_file.puts newline
      end
    end
    t_file.close
  #  FileUtils.mv(t_file.path, filename)
end


