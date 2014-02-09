require_relative '../spec_helper.rb'

describe "moodle parsing with mechanize" do
  let(:agent){Mechanize.new}
  it "selectReviewLinks should collect review links" do
    page = agent.get("file:///#{html_dir}/exam-overview-moodle-ss2013.html")
    attempts = selectReviewLinks(page)
    attempts.size.should == 7
    link = attempts.first
    link.href.should == "http://moodle2.htw-berlin.de/moodle/mod/quiz/review.php?attempt=6236"
   end

   it "should extract the student name from a page WITH profile pic" do
    # agent = Mechanize.new
     page = agent.get("file:///#{html_dir}/review-page-nutzerbild.html")
     name = extractUserName(page)
     name.should == "Teo Teststudent"
   end
   it "should extract the student name from a page with a profile subtitle" do
    # agent = Mechanize.new
     page = agent.get("file:///#{html_dir}/review-page-nutzerbild.html")
     name = extractUserName(page)
     name.should == "Teo Teststudent"
   end

   describe "attempt list" do
     it "should extract a list of attempts from the overview page" do
     #  agent = Mechanize.new
       page = agent.get("file:///#{html_dir}/exam-overview-moodle-ss2013.html")
       attempt_list = extract_attempt_list(page)
       #i = 2
       #student_name = page.at("//*[@id=\"attempts\"]/tr[#{i}]/td[3]/a[1]").text
       #attempt_url = page.at("//*[@id=\"attempts\"]/tr[#{i}]/td[3]/a[2]").attributes["href"].value
       attempt_list.size.should == 7
       student_name, attempt_url = attempt_list.first
       student_name.should == "Gustav Gans"
       attempt_url.should == "http://moodle2.htw-berlin.de/moodle/mod/quiz/review.php?attempt=6236"
     end
   end


end
