class CLI
  def run
    Scraper.new.make_teams
    puts "CLI is running"

    Team.all[1, 20].each do |team|
      puts "#{team.rank}.  #{team.name}   #{team.url}"
    end
  end
end
