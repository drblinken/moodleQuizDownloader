require 'mechanize'
require 'pdfkit'
require 'asciify'
require "bundler/setup"
require 'fileutils'

require_relative 'file_name_creator'
require_relative 'moodle_parser'

class QuizDownloader

  include MoodleParser

  attr_reader :options
  def initialize(options)
    @options = options
  end

  def run
    agent = Mechanize.new
    case options.command
      when :connect
        smoketest(options.moodle_server, options.moodle_username, options.moodle_password)
      when :list
        attempt_list = attemptlist(agent)
        puts "found #{attempt_list.length} attempts:"
        puts attempt_list.map{|a,b| a}
      when :download
        chatter "options #{options.inspect}"
        attempt_list = attemptlist(agent)
        download(attempt_list,agent)
      when :options
        puts "#{options.inspect}"

      else
        puts "command #{options.command} not recognized"
    end
  end

  def chatter(message)
    puts "==== #{message}" if options.verbose
  end

  def smoketest(server, username = "xxx", password ="xxx")
    begin
      agent = Mechanize.new
      page = login(agent,moodle_login_page(server),username,password)
      unless server_reachable?(page)
        puts "Could not connect to server #{server}"
      else
        puts "Connection to server seems to be working..."
        if login_successful?(page)
          puts "and login has been successful."
        else
          puts "but could not login with the given credentials."
        end
      end
    rescue Exception => e
        puts "could not connect to server #{server}"
        #puts e.message
    end
    page
  end

  def login_successful?(page)
    page.search('#username').empty?
  end
  def server_reachable?(page)
    !page.nil?
  end

  def attemptlist(agent)

    login(agent,moodle_login_page(options.moodle_server),options.moodle_username,options.moodle_password)

    moodle_overview_url = moodle_quiz_report(options.moodle_server)+options.exam_id.to_s
    chatter "downloading overview"
    chatter "url:#{moodle_overview_url}"

    page = agent.get(moodle_overview_url)
    attempt_list = extract_attempt_list(page)
  end

  def download(attempt_list,agent)
    FileUtils.mkdir_p(options.outputdir)
    count = 0
    attempt_list.each do | attempt|
      student_name, attempt_url = attempt

      attempt_url = attempt_url+"&showall=1"
      page = agent.get(attempt_url)
      chatter "downloading attempt"
      chatter "url  #{attempt_url}"
      chatter attempt_url
      #student = extractUserName(page)
      student = student_name

      puts "Loading: #{student}"

      chatter "downloading overview"
      chatter "outputfile:#{options.outputdir}"
      kit = PDFKit.new(page.body)
      if options.html
        chatter "save html"
        outputfile_html = FileNameCreator.file_name_for(options.outputdir,student,'html')
        File.open(outputfile_html, 'w') { |file| file.write(page.body) }
      else
        chatter "kit to file"
        outputfile = FileNameCreator.file_name_for(options.outputdir,student)
        kit.to_file(outputfile)
      end
      count += 1
    end
    puts "downloaded #{count} attempts"
  end
end

