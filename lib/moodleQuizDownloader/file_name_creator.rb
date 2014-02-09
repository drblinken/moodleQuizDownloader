require 'asciify'

class FileNameCreator

  @@regexp = /(\w*)( (\w*))? (\w*)/
  @@map = Asciify::Mapping.new(:default)

  def self.fileNameFor(outputdir,name)
    File.join(outputdir,name.asciify(@@map).gsub(@@regexp,"\\1\\3\\4.pdf"))
  end
  def self.html_fileNameFor(outputdir,name)
    File.join(outputdir,name.asciify(@@map).gsub(@@regexp,"\\1\\3\\4.html"))
  end
end
