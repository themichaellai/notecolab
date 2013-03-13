# Duke Data Script
# Author: Fabio Lucas Berger
# How to use: Call from command line and pass as args Netid, Password & parameters comma separated
# ex: ~ ruby mechanize.rb flb5 mypassword transcript
# returns JSON object of student info

require 'mechanize'
require 'json'

class StudentInfo
  possible_perms = ['schedule', 'basic_info', 'advanced_info', 'transcript'];

  # pass in terminal params

  def initialize(netid, pass)
    @netid = netid
    @pass = pass
  end

  def get_schedule()
    # init mechanize
    a = Mechanize.new
    a.user_agent_alias = 'Mac Safari'
    a.agent.redirect_ok = :all, true
    a.ssl_version = 'SSLv3'
    a.verify_mode = OpenSSL::SSL::VERIFY_NONE

    a.get('https://www.siss.duke.edu/psp/CSPRD01/?cmd=start') do |page|

      # Submit the login form
      my_page = page.form_with(:action => '/idp/authn/external') do |f|
        f.field_with(:id => "j_username").value = @netid
        f.field_with(:id => "j_password").value = @pass
      end.submit

      form = my_page.forms.first

      final = form.submit

      # begin parsing
      result = Hash.new();
      result['netid'] = @netid

      a.get('https://www.siss.duke.edu/psp/CSPRD01/EMPLOYEE/HRMS/h/?cmd=getCachedPglt&pageletname=HC_STUDENT_CENTER_HOME&tab=DEFAULT&PORTALPARAM_COMPWIDTH=Narrow&ptlayout=N') do |page|

        courses = Array.new()
        page.search('span[@class="PSHYPERLINKDISABLED"][@title="View Details"]').each do |link|
          course_info = link.content
          course_info["\n"]= " "
          courses << course_info
        end

        # seperate course name and course section
        courses.map! do |course|
          info = {}
          course.scan(/([a-zA-Z]+ \d+[a-zA-Z]*)-(\d*[a-zA-Z]?)/) do |number, section|
            info[:number] = number
            info[:section] = section
          end
          info
        end

        result[:schedule] = courses
      end
      return result
    end
  end

  def to_s()
    @netid
  end
end

if __FILE__ == $0
  print 'Username? '
  username = gets.chomp
  print 'Password? '
  system 'stty -echo'
  password = gets.chomp
  system 'stty echo'
  puts
  puts StudentInfo.new(username, password).get_schedule
end
