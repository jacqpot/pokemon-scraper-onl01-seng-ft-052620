class Pokemon
    attr_accessor :name, :type, :db 
    attr_reader :id 
    def initialize(id:nil, name:,type:,db:)
        @id = id
        @name = name 
        @type = type
        @db = db 
    end

    def self.new_from_db(row,db)
        self.new(id:row[0], name:row[1], type:row[2],db:db)
    end
    def self.save(name, type, db)

        sql = <<-sql
        INSERT INTO pokemon (name, type)
        VALUES (?, ?)
        sql
    
        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon;")[0][0]
       
    end
    def self.find(id, db)
        sql = <<-sql
        SELECT * FROM pokemon
        WHERE id = ?
        sql
        db.execute(sql,id).map {|row| self.new_from_db(row,db)}.first    
    end
end
