# moodle shows only currently enrolled users as default:
# that might be less than the number of participants that
# actually took the exam.


# testfiles: attempts-17-shown.html
# attempts-fewer-shown.html - lists fewer attempts

require_relative '../spec_helper.rb'


describe MoodleParser do
  let(:agent){Mechanize.new}

  it "counts the attempts on page" do
    page = agent.get("file:///#{html_dir}/attempts-17-shown.html")
    agent.extract_attempt_list(page).size.should == 17
  end

  it "counts the attempts on page" do
    page = agent.get("file:///#{html_dir}/attempts-fewer-shown.html")
    agent.extract_attempt_list(page).size.should == 17
  end


  it "extract the listed attempt number"

  it "compares extracted attempt number with attempts on page"
end
