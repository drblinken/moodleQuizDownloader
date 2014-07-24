require_relative '../lib/moodleQuizDownloader/option_handler.rb'
describe OptionHandler do
  before do
    @option_handler = OptionHandler.new
  end
  it "prints a usage message if no arguments given" do
    option_handler = OptionHandler.new
    expect(option_handler.usage).to include("Usage")
  end
  it "has a verbose option" do
    option_handler = OptionHandler.new(["--verbose"])
    options = option_handler.options
    expect(options.verbose).to be_truthy
  end
  it "has a smoketest option" do
    args = "--user drblinken -p geheim download connect"
    options = OptionHandler.new(args.split(" ")).options
    expect(options.command).to eq(:connect)
  end
  it "accepts only valid commands" do
    args = "--user drblinken -p geheim dosomethingelse"
    options = OptionHandler.new(args.split(" ")).options
    expect(options.command).to eq(:list)
    expect(options.usage).not_to be_nil
  end
  describe "reads username" do
    it "from option -u" do
      args = "download -u drblinken -p geheim download"
      options = OptionHandler.new(args.split(" ")).options
      expect(options.moodle_username).to eq('drblinken')
    end
    it "from option --user" do
      args = "--user drblinken -p geheim download"
      options = OptionHandler.new(args.split(" ")).options
      expect(options.moodle_username).to eq('drblinken')
    end
    it "from ENV variable as default" do
      ENV['MOODLE_USERNAME'] = 'userfromshell'
      args = "-p geheim download"
      options = OptionHandler.new(args.split(" ")).options
      expect(options.moodle_username).to eq('userfromshell')

    end
    it "ENV default is overwritten by setting" do
      ENV['MOODLE_USERNAME'] = 'userfromshell'
      args = "-u drblinken -p geheim download"
      options = OptionHandler.new(args.split(" ")).options
      expect(options.moodle_username).to eq('drblinken')
    end
  end
  it "takes the password" do
    args = "-u drblinken -p geheim download"
    options = OptionHandler.new(args.split(" ")).options
    expect(options.moodle_password).to eq('geheim')
  end
  describe "password" do
    it "is optional" do
    args = "-u drblinken -s http://moodle.de -e 4711 download"
    option_handler = OptionHandler.new(args.split(" "))
    options = option_handler.options
    expect(option_handler.valid?(options)).to be_truthy
    end
  end
  it "finds the command list among the options" do
    args= "-u drblinken list -p password"
    option_handler = OptionHandler.new(args.split(" "))
    options = option_handler.options
    expect(options.command).to be(:list)
  end
  it "finds the command 'download' among the options" do
    args = "-u drblinken -p geheim download -b"
    options = OptionHandler.new(args.split(" ")).options
    expect(options.command).to be(:download)
  end
  it "command can also be at the beginning" do
    args = "download -u drblinken -p geheim -b"
    options = OptionHandler.new(args.split(" ")).options
    expect(options.command).to be(:download)
  end
  it "--version overrides command" do
    args = "download -v"
    options = OptionHandler.new(args.split(" ")).options
    expect(options.command).to be(:version)
  end
  it "takes the exam_id" do
    args = "-e 4711 download -u drblinken -p geheim -b"
    options = OptionHandler.new(args.split(" ")).options
    expect(options.exam_id).to eq('4711')
  end
  describe "outputdir" do
    it "read from -o" do
      args = "-e 4711 download -o /tmp/bla -u drblinken -p geheim -b"
      options = OptionHandler.new(args.split(" ")).options
      expect(options.outputdir).to eq('/tmp/bla')
    end
    it "defaults to out" do
      args = "-e 4711 download -u drblinken -p geheim -b"
      options = OptionHandler.new(args.split(" ")).options
      expect(options.outputdir).to eq('out')
    end
  end
  describe "server" do
    it "from option -s" do
      args = "-s http://moodle2.htw-berlin.de download -u drblinken -p geheim download"
      options = OptionHandler.new(args.split(" ")).options
      expect(options.moodle_server).to eq('http://moodle2.htw-berlin.de')
    end
    it "from option --server" do
      args = "--server http://moodle2.htw-berlin.de --user drblinken -p geheim download"
      options = OptionHandler.new(args.split(" ")).options
      expect(options.moodle_server).to eq('http://moodle2.htw-berlin.de')
    end
    it "from ENV variable as default" do
      ENV['MOODLE_SERVER'] = 'http://moodle2.htw-berlin.de'
      args = "-p geheim download"
      options = OptionHandler.new(args.split(" ")).options
      expect(options.moodle_server).to eq('http://moodle2.htw-berlin.de')
    end
  end

  describe "validates" do
    it "all settings" do
      args = ""
      options = OptionHandler.new(args.split(" ")).parse
      expect(options.usage).not_to be_nil
      expect(options.usage).to include("server")
    end
    it "all settings given" do
      args = "-u drblinken -p geheim -s http://x.y -e 311"
      options = OptionHandler.new(args.split(" ")).parse
      expect(options.usage).to be_nil
    end

  end
end
