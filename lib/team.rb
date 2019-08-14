# class Team
#   attr_accessor :rank, :name, :url, :full_name, :nickname, :founded, :ground, :capacity, :owner, :chairman, :manager, :website
#   @@all = []
#
#   def initialize(rank = nil, name = nil, url = nil)
#     @rank = rank
#     @name = name
#     @url = url
#     @@all << self
#   end
#
#   def self.all
#     @@all
#   end
#
#   def self.new_from_table(t)
#     self.new(
#       t.css('th').text.strip,
#       t.css('td:nth-child(2) a').text,
#       "https://en.wikipedia.org#{t.css('a').attribute('href')}"
#       )
#   end
#
#   def doc
#     @doc ||= Nokogiri::HTML(open(self.url))
#   end
#
#   def full_name
#     @full_name = doc.css("table.infobox.vcard tr:contains('Full name') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
#   end
#
#   def nickname
#     @nickname = doc.css("table.infobox.vcard tr:contains('Nickname(s)') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
#   end
#
#   def founded
#     @founded = doc.css("table.infobox.vcard tr:contains('Founded') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
#   end
#
#
#   def ground
#     @ground = doc.css("table.infobox.vcard tr:contains('Ground') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
#   end
#
#   def capacity
#     # @capacity = doc.css("table.infobox.vcard tr:contains('Capacity') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
#     @capacity = doc.css("table.infobox.vcard tr:contains('Capacity') td").text[0,6]
#   end
#
#   def owner
#     # @owner = doc.css("table.infobox.vcard tr:contains('Owner') td").text
#     if doc.css("table.infobox.vcard tr:contains('Owner') td").text != ""
#       @owner = doc.css("table.infobox.vcard tr:contains('Owner') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
#     else
#       @owner = "N/A"
#     end
#   end
#
#   def chairman
#     if doc.css("table.infobox.vcard tr:contains('Chairman') td").text != ""
#       @chairman = doc.css("table.infobox.vcard tr:contains('Chairman') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
#     elsif doc.css("table.infobox.vcard tr:contains('Co-chairmen') td").text != ""
#       @chairman = doc.css("table.infobox.vcard tr:contains('Co-chairmen') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
#     else
#       @chairman = "N/A"
#     end
#   end
#
#   def manager
#     # @manager = doc.css("table.infobox.vcard tr:contains('Manager') td").text
#     if doc.css("table.infobox.vcard tr:contains('Manager') td").text != ""
#       @manager = doc.css("table.infobox.vcard tr:contains('Manager') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
#     elsif doc.css("table.infobox.vcard tr:contains('Head Coach') td").text != ""
#       @manager = doc.css("table.infobox.vcard tr:contains('Head Coach') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
#     elsif doc.css("table.infobox.vcard tr:contains('Head coach') td").text != ""
#       @manager = doc.css("table.infobox.vcard tr:contains('Head coach') td").text.delete_suffix('[1]').delete_suffix('[2]').delete_suffix('[3]').delete_suffix('[4]')
#     else
#       @manager = "N/A"
#     end
#   end
#
#   def website
#     @website = doc.css("table.infobox.vcard tr:contains('Website') a").attribute('href').text
#   end
#
# end

class Team
  attr_accessor :rank, :name, :url, :full_name, :nickname, :founded, :ground, :capacity, :owner, :chairman, :manager, :website, :team_info
  @@all = []

  def initialize(hash)
    hash.each {|k,v| self.send(("#{k}="), v)}
    @@all << self
  end

  def self.make_teams(teams)
    teams.each {|t| self.new(t)}
  end

  def add_team_attributes(attributes_hash)
    attributes_hash.each {|k, v| self.send(("#{k}="), v)}
  end

  def self.team_info
    @team_info = Scraper.new.scrape_team_page(@url)
  end

  def self.all
    @@all
  end









end
