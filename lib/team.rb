class Team
  attr_accessor :rank, :name, :url, :full_name, :nickname, :founded, :alt_founded, :ground, :alt_ground, :capacity, :alt_capacity, :owner, :alt_owner, :chairman, :alt_chairman, :manager, :alt_manager, :website, :alt_website
  @@all = []

  def initialize(rank = nil, name = nil, url = nil)
    @rank = rank
    @name = name
    @url = url
    @@all << self
  end

  def self.all
    @@all
  end

  def self.new_from_table(t)
    self.new(
      t.css('th').text.strip,
      t.css('td:nth-child(2) a').text,
      "https://en.wikipedia.org#{t.css('a').attribute('href')}"
      )
  end

  def doc
    @doc ||= Nokogiri::HTML(open(self.url))
  end

  def full_name
    @full_name = doc.css('table.infobox.vcard tr:nth-child(2) td').text.strip.delete_suffix("[1]").delete_suffix("[2]")
  end

  def nickname
    @nickname = doc.css('table.infobox.vcard tr:nth-child(3) td').text.strip.delete_suffix("[1]").delete_suffix("[2]")
  end

  def founded
    @founded = doc.css('table.infobox.vcard tr:nth-child(5) span:nth-child(1)').text.strip.delete_prefix("; ")[0, 13]
  end

  def alt_founded
    @alt_founded = doc.css('table.infobox.vcard tr:nth-child(4) span:nth-child(1)').text.strip.delete_prefix("; ")[0, 13]
  end

  def ground
    @ground = doc.css('table.infobox.vcard tr:nth-child(6) td').text.strip.delete_suffix("[1]").delete_suffix("[2]")
  end

  def alt_ground
    @alt_ground = doc.css('table.infobox.vcard tr:nth-child(5) td').text.strip.delete_suffix("[1]").delete_suffix("[2]")
  end

  def capacity
    @capacity = doc.css('table.infobox.vcard tr:nth-child(7) td').text.strip.delete_suffix("[1]").delete_suffix("[2]")
  end

  def alt_capacity
    @alt_capacity = doc.css('table.infobox.vcard tr:nth-child(6) td').text.strip.delete_suffix("[1]").delete_suffix("[2]")
  end

  def owner
    @owner = doc.css('table.infobox.vcard tr:nth-child(8) td').text.strip.delete_suffix("[1]").delete_suffix("[2]")
  end

  def alt_owner
    @alt_owner = doc.css('table.infobox.vcard tr:nth-child(7) td').text.strip.delete_suffix("[1]").delete_suffix("[2]")
  end

  def chairman
    @chairman = doc.css('table.infobox.vcard tr:nth-child(9) td').text.strip.delete_suffix("[1]").delete_suffix("[2]")
  end

  def alt_chairman
    @alt_chairman = doc.css('table.infobox.vcard tr:nth-child(8) td').text.strip.delete_suffix("[1]").delete_suffix("[2]")
  end


  def manager
    @manager = doc.css('table.infobox.vcard tr:nth-child(10) td').text.strip.delete_suffix("[1]").delete_suffix("[2]")
  end

  def alt_manager
    @alt_manager = doc.css('table.infobox.vcard tr:nth-child(9) td').text.strip.delete_suffix("[1]").delete_suffix("[2]")
  end

  def website
    @website = doc.css('table.infobox.vcard tr:nth-child(13) a').attribute('href').text
  end

  def alt_website
    @alt_website = doc.css('table.infobox.vcard tr:nth-child(12) a').attribute('href').text
  end
end
