require_relative '../lib/moodleQuizDownloader/file_name_creator'

describe "FileNameCreator" do
    def outputdir
       '/temp'
     end
    it "should create name by combining first and last name" do
      name = "Teo Teststudent"
      expect(FileNameCreator.file_name_for(outputdir,name)).to eq("#{outputdir}/TeoTeststudent.pdf")
    end
    it "should replace umlauts in the file name" do
      name = "Leo Lüße"
      expect(FileNameCreator.file_name_for(outputdir,name)).to eq("#{outputdir}/LeoLuesse.pdf")
    end
    it "should handle middle names" do
      name = "Teo von Teststudent"
      expect(FileNameCreator.file_name_for(outputdir,name)).to eq("#{outputdir}/TeovonTeststudent.pdf")
    end
    it "should handle hyphens in the last name" do
      name = "An Xa-Yyy"
      expect(FileNameCreator.file_name_for(outputdir,name)).to eq("#{outputdir}/AnXaYyy.pdf")
    end

    it "should create html extensions" do
      name = "Hans Uwe Müller-Heinz"
      expect(FileNameCreator.file_name_for(outputdir,name,'html')).to eq("#{outputdir}/HansUweMuellerHeinz.html")
    end
end
