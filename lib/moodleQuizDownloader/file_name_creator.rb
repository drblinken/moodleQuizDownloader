require 'asciify'

class FileNameCreator

  @@regexp = /(\w*)( (\w*))? (\w*)/
  @@map = Asciify::Mapping.new(:default)

  def self.file_name_for(outputdir,name,extension = 'pdf')
    name = name.gsub("-","")
    File.join(outputdir,name.asciify(@@map).gsub(@@regexp,"\\1\\3\\4.#{extension}"))
  end
end
