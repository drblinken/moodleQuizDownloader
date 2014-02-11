#<select id="id_attempts" name="attempts">
#
#    <option selected="selected" value="enrolled_with"><#/option>
#    <option value="enrolled_without"></option>
#    <option value="enrolled_any"></option>
#    <option value="all_with"></option>
#
#</select>
#
#
#    <input id="id_submitbutton" type="submit" #value="Bericht anzeigen" name="submitbutton"></input#>
#
#


# moodle selecty "students who take the quiz and are enrolled"
# as default -
# to archive quizzes later on, this Module selects
# all attempts.


# form
#mform1
module MoodleAttemptSelector

  def select_all_attempts_done(page)
    form = page.form_with(id: 'mform1')
    selectlist = form.field_with(id: 'id_attempts')
    selectlist.value="all_with"
    page = form.submit
  end



end


