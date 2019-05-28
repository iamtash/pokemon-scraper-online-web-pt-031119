class Pokemon

  attr_accessor :name, :type, :hp
  attr_reader :id, :db

  def initialize(id:, name:, type:, hp: nil, db:)
    @id = id
    @name = name
    @type = type
    @hp = hp
    @db = db
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon(name, type)
      VALUES (?,?)
    SQL
    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?
      LIMIT 1
    SQL

    row = db.execute(sql, id).first
    self.new(id: row[0], name: row[1], type: row[2], hp: row[3], db: db)
  end

  def alter_hp(new_hp, db)
    sql = 'UPDATE pokemon SET name = ?, type = ?, hp = ? WHERE id = ?'
    db.execute(sql, self.name, self.type, new_hp, self.id)
  end

end
