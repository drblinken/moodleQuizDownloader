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
    extract_attempt_list(page).size.should == 17
  end

  it "counts the attempts on page" do
    page = agent.get("file:///#{html_dir}/attempts-fewer-shown.html")
    extract_attempt_list(page).size.should == 9
  end


  it "extracts the listed attempt number" do
    page = agent.get("file:///#{html_dir}/attempts-fewer-shown.html")
    extract_attempt_count(page).should == 17
  end


  it "compares extracted attempt number with attempts on page" do
    page = agent.get("file:///#{html_dir}/attempts-fewer-shown.html")
    all_attempts_shown(page).should == false
  end

  it "compares extracted attempt number with attempts on page" do
    page = agent.get("file:///#{html_dir}/attempts-17-shown.html")
    all_attempts_shown(page).should == true
  end

  it "on a page with not all attempts, extract_complete_attempt_list automatically selects all_with" do
    page = agent.get("file:///#{html_dir}/attempts-fewer-shown.html")
    attempt_list = extract_complete_attempt_list(page)
    attempt_list.size.should == 17

  end

end
