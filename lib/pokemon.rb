require "pry"

class Pokemon
  attr_accessor :id, :name, :type, :db, :hp

  def initialize(id:, name:, type:, db:, hp:nil) #hp is an optional value, init with nil, updated with .find
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
    # is this duplicate work?
    # the hp is optional, it is not required to initialize an opbject but is auto defualted to nil \
  end

  def self.save(name, type, db)  #positional not defined

    sql = <<-SQL
      INSERT INTO pokemon(name, type)
      VALUES(?, ?)
    SQL

    db.execute(sql, name, type)

    #why do we go from DB[:conn] to db?
    #are the db here the same?
  end

  def self.find(id, db)

    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?
    SQL

    db.execute(sql, id).map do |row|
      Pokemon.new(id: row[0], name: row[1], type: row[2], db: db, hp: row[3])

      #the find is overwriting the pokemon object
      #solution - add hp:row[3] pry into row nextime

    end.first #The .first is v important!!! returns an array, get down one level
  end


  def alter_hp(hp, db)

    sql = <<-SQL
      UPDATE pokemon
      SET hp = ?
      WHERE ID = ?
    SQL

    db.execute(sql, hp, self.id)

  end

  #is this saving or storing two separate objects?  the instance and the db value?
  #It is not adding the HP column in the data base I THINK
  # there is an issue between the named parameters and when I change and pass in new ones
# expect(Pokemon.find(1, @db).hp).to eq(59)
  # https://github.com/learn-co-curriculum/pokemon-scraper/wiki/Topic-Review
    # binding.pry
end
