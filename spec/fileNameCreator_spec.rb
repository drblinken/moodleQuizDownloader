require_relative '../lib/moodleQuizDownloader/file_name_creator'

describe "FileNameCreator" do
    def outputdir
       '/temp'
     end
    it "should create name by combining first and last name" do
      name = "Teo Teststudent"
      FileNameCreator.file_name_for(outputdir,name).should == "#{outputdir}/TeoTeststudent.pdf"
    end
    it "should replace umlauts in the file name" do
      name = "Leo Lüße"
      FileNameCreator.file_name_for(outputdir,name).should == "#{outputdir}/LeoLuesse.pdf"
    end
    it "should handle middle names" do
      name = "Teo von Teststudent"
      FileNameCreator.file_name_for(outputdir,name).should == "#{outputdir}/TeovonTeststudent.pdf"
    end
    it "should handle hyphens in the last name" do
      name = "An Xa-Yyy"
      FileNameCreator.file_name_for(outputdir,name).should == "#{outputdir}/AnXaYyy.pdf"
    end

    it "should create html extensions" do
      name = "Hans Uwe Müller-Heinz"
      FileNameCreator.file_name_for(outputdir,name,'html').should == "#{outputdir}/HansUweMuellerHeinz.html"
    end
end
