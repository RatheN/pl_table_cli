# class Scraper
#   def get_page
#     Nokogiri::HTML(open("https://en.wikipedia.org/wiki/Template:2018%E2%80%9319_Premier_League_table"))
#   end
#
#   def scrape_index
#     self.get_page.css('.wikitable tr')
#   end
#
#   def make_teams
#     scrape_index.each do |t|
#       Team.new_from_table(t)
#     end
#   end
# end


class Scraper
  def initialize(url = nil)
    @url = url
  end

  def self.get_page
    Nokogiri::HTML(open("https://en.wikipedia.org/wiki/Template:2018%E2%80%9319_Premier_League_table"))
  end

  def self.scrape_index
    teams = self.get_page.css('.wikitable tr').map do |s|
      {
        :rank => s.css('th').text.strip,
        :name => s.css('td:nth-child(2) a').text,
        :url => "https://en.wikipedia.org#{s.css('a').attribute('href')}"
      }
    end
  end

  # def self.scrape_team_page(url)
  #   doc = Nokogiri::HTML(open(url))
  #
  #   team_information = doc.css("table.infobox.vcard").map do |i|
  #     {
  #       :full_name => i.css("tr:contains('Full name') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]'),
  #       :nickname => i.css("tr:contains('Nickname(s)') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
  #
  #
  #
  #
  #     }
  #   end
  # end


  def self.scrape_team_page(team)
    url = team.url
    doc = Nokogiri::HTML(open(url))

    team_information = doc.css("table.infobox.vcard").map do |i|
        team.full_name = i.css("tr:contains('Full name') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
        team.nickname = i.css("tr:contains('Nickname(s)') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
        team.founded = i.css("tr:contains('Founded') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
        team.ground = i.css("tr:contains('Ground') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
        team.capacity = i.css("tr:contains('Capacity') td").text[0,6]
        if i.css("tr:contains('Owner') td").text != ""
          team.owner = i.css("tr:contains('Owner') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
        else
          team.owner = "N/A"
        end
        if i.css("tr:contains('Chairman') td").text != ""
          team.chairman = i.css("tr:contains('Chairman') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
        elsif i.css("tr:contains('Co-chairmen') td").text != ""
          team.chairman = i.css("tr:contains('Co-chairmen') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
        else
          team.chairman = "N/A"
        end
        if i.css("tr:contains('Manager') td").text != ""
          team.manager = i.css("tr:contains('Manager') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
        elsif i.css("tr:contains('Head Coach') td").text != ""
          team.manager = i.css("tr:contains('Head Coach') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
        elsif i.css("tr:contains('Head coach') td").text != ""
          team.manager = i.css("tr:contains('Head coach') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
        else
          team.manager = "N/A"
        end
        team.website = i.css("tr:contains('Website') a").attribute('href')

    end
  end
end
