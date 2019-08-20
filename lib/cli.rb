class CLI
  def run
    welcome
    setup
    prompt_for_table
    team_selection
    end_prompt
  end

  def welcome
    puts "\n\n----------------------------------------"
    puts "Welcome to the 2018/19 Premier League Table."
    puts "View different sections of the table and find more information on your favorite teams."
  end

  def setup
    teams = Scraper.scrape_index
    Team.make_teams(teams)
  end

  def prompt_for_table
    puts "\n\nWould you like to view the top of the table or the bottom of the table?"
    puts "(please enter: 'top' or 'bottom')"
    input = gets.strip.downcase

    if input == "top"
      input = 0
      show_table(input)
    elsif input == "bottom"
      input = 10
      show_table(input)
    else
      puts "\nPlease enter a valid option."
      prompt_for_table
    end
  end

  def team_selection
    puts "\n\n----------------------------------------"
    puts "What team would you like more information on?"
    puts "(Enter a number from 1 - 20)"
    input = gets.strip.to_i

    if input >= 1 && input <= 20
      team_info(input-1)
    else
      while input < 1 || input > 20
        puts "Please enter a valid number from 1 - 20"
        input = gets.strip.to_i
      end
      team_info(input-1)
    end
  end

  def show_table(s)
    if s == 0
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
    team = Team.all[r]
    Scraper.scrape_team_page(team) if !team.full_name
    puts "\n\n---------------#{team.full_name}---------------\n\n"
    puts "Nickname(s):          #{team.nickname}"
    puts "Ground(stadium):      #{team.ground}"
    puts "Capacity:             #{team.capacity}"
    puts "Founded:              #{team.founded}"
    puts "Owner(s):             #{team.owner}"
    puts "Chairman(Chairmen):   #{team.chairman}"
    puts "Manager:              #{team.manager}"
    puts "Website:              #{team.website}"
    end_prompt
  end

  def end_prompt
    puts "\n\n----------------------------------------"
    puts "Would you like to view a different section of the table, search for a different team, restart, or exit?"
    puts "('table', 'team', 'restart', or 'exit')"
    input = gets.strip.downcase

    if input == "table"
      prompt_for_table
      end_prompt
    elsif input == "team"
      team_selection
      end_prompt
    elsif input == "restart"
      run
    elsif input == "exit"
      closing_statement
    else
      puts "\nPlease enter a valid option."
      end_prompt
    end
  end

  def closing_statement
    puts "\n\nThank you. Best of luck to your favorite team next year!"
    exit
  end
end
