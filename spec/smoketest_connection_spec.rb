require_relative '../lib/moodleQuizDownloader/quiz_downloader'

describe "QuizDownloader" do
  def html_dir
    html_dir = File.join(File.dirname(__FILE__),'moodleparsing')
  end

  it "should detect login failure" do
    agent = Mechanize.new
    page = agent.get("file:///#{html_dir}/login_failed.html")
    qd = QuizDownloader.new
    qd.login_successful?(page).should be_false
  end
  it "should detect successful login" do
    agent = Mechanize.new
    page = agent.get("file:///#{html_dir}/login_successful.html")
    qd = QuizDownloader.new
    qd.login_successful?(page).should be_true
  end
end