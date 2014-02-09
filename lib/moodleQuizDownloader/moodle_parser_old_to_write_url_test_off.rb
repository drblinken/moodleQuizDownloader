module MoodleParser
    @@user_view_regexp = Regexp.new('http://moodle2.htw-berlin.de/moodle/user/view.php')

    def moodle_login_page(server)
    "#{server}"
    # "#{server}/moodle/login/index.php"
  end
  def moodle_item(server)
    "#{server}/moodle/mod/quiz/view.php?id="
  end
  def moodle_quiz_report(server)
    "#{server}/moodle/mod/quiz/report.php?mode=overview&id="
  end

  def login(agent,moodle_login_page,moodle_username,moodle_password)
    puts "++++#{moodle_login_page}"
    page = agent.get(moodle_login_page)
    form = page.forms[1]
    form.username = moodle_username
    form.password = moodle_password
    page = form.submit
  end

  def selectReviewLinks(page)
    page.links.select do |ll|
      cls = ll.attributes.attributes['class']
      cls && cls.value == 'reviewlink'
    end
  end

  def extract_attempt_list(page)
   i = 1
   result_list = []
   while page.at("//*[@id=\"attempts\"]/tbody/tr[#{i}]/td[3]/a[1]") do
     student_name = page.at("//*[@id=\"attempts\"]/tbody/tr[#{i}]/td[3]/a[1]").text
     attempt_url = page.at("//*[@id=\"attempts\"]/tbody/tr[#{i}]/td[3]/a[2]").attributes["href"].value
     result_list << [student_name,attempt_url]
     i += 1
   end
   result_list
  end

  def extractUserName(page)

    l = page.links.select {|x| @@user_view_regexp.match(x.href)}
    nutzerbild_string = "Nutzerbild "
    nutzerbild = l.select{ |x| /Nutzerbild/.match(x.text)}
    if nutzerbild.empty?
      nutzerbild = l.select{ |x| /Picture of/.match(x.text)}
      nutzerbild_string = "Picture of "
    end
    if nutzerbild.empty?
      puts "## WARNING! ##"
      puts "could not extract user name"
      puts "## nutzerbild #{nutzerbild.inspect}"
      puts "-- nutzerbild_string #{nutzerbild_string}"
      return "Unknown Student"
    end
    nutzerbild.first.text.gsub(nutzerbild_string,"")
  end

end