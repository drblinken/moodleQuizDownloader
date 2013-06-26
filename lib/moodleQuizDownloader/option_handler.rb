require 'optparse'
require 'ostruct'

class OptionHandler
  attr_reader :options, :optionparser
  def initialize(arguments = [])
    @arguments = arguments
    @options, @optionparser = parse(arguments)
  end
  def usage
    "Usage: bla bla"
  end


  def parse(args)
    # The options specified on the command line will be collected in *options*.
    # We set default values here.
    options = OpenStruct.new
    options.verbose = false
    options.download = false
    options.list = true
    options.moodle_username = ENV['MOODLE_USERNAME']
    options.moodle_password = ENV['MOODLE_PASSWORD']
    options.moodle_server = ENV['MOODLE_SERVER']
    options.outputdir = "."
    options.exam_id = 0
    options.command = :list


    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: mqd.rb [options] list|download"

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
      opts.on("-u", "--user USERNAME",
              "Your Moodle User Name",
              "(can also be set via MOODLE_USERNAME environment variable)") do |username|
        options.moodle_username = username
      end
      opts.on("-p", "--password PASSWORD]",
              "Your Moodle Password",
              "(can also be set via MOODLE_PASSWORD environment variable)") do |password|
        options.moodle_password = password
      end

      opts.on("-s", "--server SERVER]",
              "Your Moodle Server",
              "(can also be set via MOODLE_SERVER environment variable)") do |server|
        options.moodle_server = server
      end

      opts.on("-b", "--[no-]verbose", "Run verbosely") do |v|
        options.verbose = v
      end

      opts.separator ""
      opts.separator "Common options:"

      # No argument, shows at tail.  This will print an options summary.
      # Try it and see!
      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end

      # Another typical switch to print the version.
      opts.on_tail("-v", "--version", "Show version") do
        options.command = :version
      end
    end
    opt_parser.order(args) do | command |
      options.command = command.to_sym
    end
    return options, opt_parser
  end  # parse()
end
