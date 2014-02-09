require 'optparse'
require 'ostruct'

class OptionHandler
  def valid_commands
    [:list, :download, :connect, :options]
  end
  attr_reader :options, :optionparser
  def initialize(arguments = [])
    @arguments = arguments
    @options, @optionparser = parse(arguments)
  end
  def usage
    @options.usage
  end

  def validate(options,optionparser)
    options.usage = optionparser.help unless valid?(options)
  end
  def valid?(options)
    options.valid &&
    options.moodle_username &&
    options.moodle_password &&
    options.moodle_server &&
    options.exam_id != 0
  end

  def parse(args = @arguments)
    # The options specified on the command line will be collected in *options*.
    # We set default values here.
    options = OpenStruct.new
    options.valid = true
    options.verbose = false
    options.moodle_username = ENV['MOODLE_USERNAME']
    options.moodle_password = ENV['MOODLE_PASSWORD']
    options.moodle_server = ENV['MOODLE_SERVER']
    options.outputdir = "out"
    options.exam_id = 0
    options.command = :list
    options.usage = nil
    options.html = false


    opt_parser = OptionParser.new do |opts|
      opts.banner = <<DELIM
Usage: moodleQuizDownloader [options] <command>
Where <command> is one of the following: #{valid_commands.join(", ")}
DELIM

      opts.separator ""
      opts.separator "Specific options:"

      opts.on("-e", "--exam EXAM_ID",
              "The ID of the Exam to be downloaded") do | id |
        options.exam_id = id
      end
      opts.on("-o", "--outputdir DIR",
              "Output Dir (defaults to . )") do | dir |
        options.outputdir = dir
      end
      opts.on("-h", "--html",
              "Save Exams in HTML instead as PDFs") do | html |
        options.html = html
      end

      opts.on("-u", "--user USERNAME",
              "Your Moodle User Name",
              "(can also be set via MOODLE_USERNAME environment variable)") do |username|
        options.moodle_username = username
      end
      opts.on("-p", "--password PASSWORD",
              "Your Moodle Password",
              "(can also be set via MOODLE_PASSWORD environment variable)") do |password|
        options.moodle_password = password
      end

      opts.on("-s", "--server SERVER",
              "Your Moodle Server",
              "(can also be set via MOODLE_SERVER environment variable)") do |server|
        options.moodle_server = server
      end

      opts.separator ""
      opts.separator "Common options:"

      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end

      opts.on_tail("-v", "--version", "Show version") do
        options.command = :version
      end
      opts.on("-b", "--[no-]verbose", "Run verbosely") do |v|
        options.verbose = v
      end

    end
    opt_parser.order(args) do | command |
      command = command.to_sym
      if valid_commands.include?(command)
        options.command = command
      else
        options.valid=false
      end
    end
    validate(options,opt_parser)
    options
  end  # parse()
end
