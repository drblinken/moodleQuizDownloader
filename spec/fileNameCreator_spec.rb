require_relative '../lib/moodleQuizDownloader/file_name_creator'

describe "FileNameCreator" do
    def outputdir
       '/temp'
     end
    it "should create name by combining first and last name" do
      name = "Teo Teststudent"
      FileNameCreator.fileNameFor(outputdir,name).should == "#{outputdir}/TeoTeststudent.pdf"
    end
    it "should replace umlauts in the file name" do
      name = "Leo Lüße"
      FileNameCreator.fileNameFor(outputdir,name).should == "#{outputdir}/LeoLuesse.pdf"
    end
    it "should handle middle names" do
      name = "Teo von Teststudent"
      FileNameCreator.fileNameFor(outputdir,name).should == "#{outputdir}/TeovonTeststudent.pdf"
    end
end
