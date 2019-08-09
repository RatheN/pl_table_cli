class Scraper
  def get_page
    Nokogiri::HTML(open("https://en.wikipedia.org/wiki/Template:2018%E2%80%9319_Premier_League_table"))
  end

  def scrape_index
    self.get_page.css('.wikitable tr')
  end

  def make_teams
    scrape_index.each do |t|
      Team.new_from_table(t)
    end
  end
end