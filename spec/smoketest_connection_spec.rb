require_relative '../lib/moodleQuizDownloader/quiz_downloader'

describe "QuizDownloader" do

  #https://relishapp.com/rspec/rspec-mocks/docs/method-stubs
  let(:options){ double()}
  let(:html_dir){ File.join(File.dirname(__FILE__),'moodleparsing/testfiles') }

  it "should detect login failure" do
    agent = Mechanize.new
    page = agent.get("file:///#{html_dir}/login_failed.html")
    qd = QuizDownloader.new(options)
    expect(qd.login_successful?(page)).to  be_falsey
  end
  it "should detect successful login" do
    agent = Mechanize.new
    page = agent.get("file:///#{html_dir}/login_successful.html")
    qd = QuizDownloader.new(options)
    expect(qd.login_successful?(page)).to be_truthy
  end
end
