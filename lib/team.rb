class Team
  attr_accessor :rank, :name, :url
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
end
