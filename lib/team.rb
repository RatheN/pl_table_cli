class Team
  attr_accessor :rank, :name, :url, :full_name, :nickname, :founded, :ground, :capacity, :owner, :chairman, :manager, :website
  @@all = []

  def initialize(hash)
    hash.each {|k,v| self.send(("#{k}="), v)}
    @@all << self
  end

  def self.make_teams(teams)
    teams.each {|t| self.new(t)}
  end

  def self.all
    @@all
  end
end
