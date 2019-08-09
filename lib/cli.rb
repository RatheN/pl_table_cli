class CLI
  def run
    Scraper.new.make_teams
    puts "CLI is running"
    start
    # Team.all[1, 20].each do |team|
    #   puts "#{team.rank} #{team.name}\nfull name - #{team.full_name}\nnickname - #{team.nickname}\nfounded - #{team.founded}\nground - #{team.ground}\ncapacity - #{team.capacity}\nowner - #{team.owner}\nchairman - #{team.chairman}\nmanager - #{team.manager}\n\n\n"
    # end
    # puts "#{Team.all[1].name}\nfull name - #{Team.all[1].full_name}\nnick name - #{Team.all[1].nickname}\n#{Team.all[1].founded}\n#{Team.all[1].ground}\n#{Team.all[1].capacity}\n#{Team.all[1].owner}\n#{Team.all[1].chairman}\n#{Team.all[1].manager}\n#{Team.all[1].website}"
  end

  def start
    puts "Would you like to view the top of the table or the bottom of the table?"
    puts "(please enter: 'top' or 'bottom')"
    input = gets.strip.downcase

    if input == "top"
      input = 1
      show_table(input)
    elsif input == "bottom"
      input = 11
      show_table(input)
    else
      puts "\nPlease enter a valid option.\n\n"
      start
    end

    puts "\n\n----------------------------------------"
    puts "What team would you like more information on?"
    puts "(Enter a number from 1 - 20)"
    input = gets.strip.to_i

    if input >= 1 && input <= 20
      team_info(input)
    else
      while input < 1 || input > 20
        puts "Please enter a valid number from 1 - 20"
        input = gets.strip.to_i
      end
      team_info(input)
    end

    puts "\n\n----------------------------------------"
    puts "Would you like to view a different team or section of the table? Y/N"
    input = gets.strip.downcase

    if input == "y"
      start
    else
      puts "\n\nThank you. Best of luck to your favorite team next year!"
      exit
    end
  end

  def show_table(s)
    if s == 1
      puts "\n\n----------Top of the 2018/19 Premier League Table----------\n\n"
      Team.all[s, 10].each do |t|
        puts "#{t.rank}.  #{t.name}"
      end
    else
      puts "\n\n----------Bottom of the 2018/19 Premier League Table----------\n\n"
      Team.all[s, 10].each do |t|
        puts "#{t.rank}.  #{t.name}"
      end
    end
  end

  def team_info(r)
    puts "\n\n---------------#{Team.all[r].full_name}---------------\n\n"
    puts "Nickname(s):          #{Team.all[r].nickname}"
    puts "Ground(stadium):      #{Team.all[r].ground}"
    puts "Capacity:             #{Team.all[r].capacity}"
    puts "Founded:              #{Team.all[r].founded}"
    puts "Owner(s):             #{Team.all[r].owner}"
    puts "Chairman(Chairmen):   #{Team.all[r].chairman}"
    puts "Manager:              #{Team.all[r].manager}"
    puts "Website:              #{Team.all[r].website}"
  end

end
