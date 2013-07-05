require 'mechanize'
require 'pdfkit'
require 'asciify'
require "bundler/setup"
require 'fileutils'
require_relative 'file_name_creator'

require_relative 'moodle_parser'



class QuizDownloader
  include MoodleParser

  def smoketest(server)
    begin
      agent = Mechanize.new
      page = login(agent,moodle_login_page(server),"xxx","xxx")
      if page.nil?
        puts "could not connect to server #{server}"
      else
        puts "connection to server seems to be working"
      end
    rescue Exception => e
        puts "could not connect to server #{server}"
        #puts e.message
    end
    page
  end
  def attemptlist(options,agent)
    puts "connecting to moodle" if options.verbose
    page = login(agent,moodle_login_page(options.moodle_server),options.moodle_username,options.moodle_password)
    moodle_overview_url = moodle_quiz_report(options.moodle_server)+options.exam_id.to_s
    puts "==== downloading overview" if options.verbose
    puts moodle_overview_url if options.verbose
    page = agent.get(moodle_overview_url)
    #attempts = selectReviewLinks(page)
    attempt_list = extract_attempt_list(page)
  end

  def download(attempt_list,options,agent)
    FileUtils.mkdir_p(options.outputdir)
    attempt_list.each do | attempt|
      student_name, attempt_url = attempt

      attempt_url = attempt_url+"&showall=1"
      page = agent.get(attempt_url)
      puts "==== downloading attempt" if options.verbose
      puts attempt_url if options.verbose
      #student = extractUserName(page)
      student = student_name
      outputfile = FileNameCreator.fileNameFor(options.outputdir,student)
      puts "Loading: #{student}"
      kit = PDFKit.new(page.body)
      kit.to_file(outputfile)
    end
  end


  def run(options)
    agent = Mechanize.new
    case options.command
      when :connect
        smoketest(options.moodle_server)
      when :list
        attempt_list = attemptlist(options,agent)
        puts "found #{attempt_list.length} attempts:"
        puts attempt_list.map{|a,b| a}
      when :download
        attempt_list = attemptlist(options,agent)
        download(attempt_list,options,agent)
      else
        puts "command #{options.command} not recognized"
    end
  end


end

