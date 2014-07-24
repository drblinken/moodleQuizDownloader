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
    expect(extract_attempt_list(page).size).to eq 17
  end

  it "counts the attempts on page" do
    page = agent.get("file:///#{html_dir}/attempts-fewer-shown.html")
    expect(extract_attempt_list(page).size).to eq 9
  end


  it "extracts the listed attempt number" do
    page = agent.get("file:///#{html_dir}/attempts-fewer-shown.html")
    expect(extract_attempt_count(page)).to eq 17
  end


  it "compares extracted attempt number with attempts on page" do
    page = agent.get("file:///#{html_dir}/attempts-fewer-shown.html")
    expect(all_attempts_shown(page)).to eq false
  end

  it "compares extracted attempt number with attempts on page" do
    page = agent.get("file:///#{html_dir}/attempts-17-shown.html")
    expect(all_attempts_shown(page)).to eq true
  end

  #it "on a page with not all attempts, extract_complete_attempt_list automatically selects all_with" do
   # pending
   # page = agent.get("file:///#{html_dir}/attempts-fewer-shown.html")
   # this doesn't work with saved files as this clicking on the
   # link -> goes to login page
   # attempt_list = extract_complete_attempt_list(page)
   # attempt_list.size).to eq 17

  #end

end
