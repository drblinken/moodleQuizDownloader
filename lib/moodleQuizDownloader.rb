require_relative "moodleQuizDownloader/version.rb"
require_relative "moodleQuizDownloader/option_handler.rb"
require_relative "moodleQuizDownloader/quiz_downloader.rb"

module MoodleQuizDownloader
  def run_script
    options = OptionHandler.new(ARGV).parse
    if options.usage
      puts options.usage
      exit
    end
    QuizDownloader.new.run(options)
  end
end

include MoodleQuizDownloader
run_script
