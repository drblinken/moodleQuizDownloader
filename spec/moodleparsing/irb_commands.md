
# commands for irb

require 'mechanize'
agent = Mechanize.new

html_dir = '/Users/kleinen/code/ruby/moodleQuizDownloader/spec/moodleparsing/testfiles'

page = agent.get("file:///#{html_dir}/attempts-fewer-shown.html")


 quizattemptcounts_div = page.at('.quizattemptcounts')

