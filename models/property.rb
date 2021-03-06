# #Codeclan Week 03 Day 02
# Pizza Shop Codealong
# Ruby, Databases and their interactions
# Console file - equivalent to a runner
# There is no testing for databases on this course - can look into elsewhere.

require('PG')
require('pry')

class Property

  attr_accessor :address, :value, :number_of_bedrooms, :year_built, :status, :square_footage, :build_type, :id

  def initialize(details_hash)
    @address = details_hash['address']
    @value = details_hash['value']
    @number_of_bedrooms = details_hash['number_of_bedrooms']
    @year_built = details_hash['year_built']
    @status = details_hash['status']
    @square_footage = details_hash['square_footage']
    @build_type = details_hash['build_type']
    @id = details_hash['id'].to_i if details_hash['id'] #will assign this id if it has one, not required to instantiate
  end


  def save
    #connect to DB. Ask PG to connect, return a DB object.
    db = PG.connect( { dbname: 'properties', host: 'localhost'})

    #Define SQL - USE DOUBLE QUOTES HERE AS SQL WITHIN WILL USE SINGLE AROUND INTERPOLATED STRINGS
    sql = "INSERT INTO properties (
    address,
    value,
    number_of_bedrooms,
    year_built,
    status,
    square_footage,
    build_type
    ) VALUES (
      $1,
      $2,
      $3,
      $4,
      $5,
      $6,
      $7
    )
    RETURNING id" #get id column from DB so that you can save on object
    values = [@address, @value, @number_of_bedrooms, @year_built, @status, @square_footage, @build_type] #order of array needs to be in order of dollar values
    db.prepare("save_as", sql ) #PREPARED STATEMENT, BREAK SQL INJECTION ATTACK
    #execute SQL on DB object. SQL instruction  passed as a parameter and executed on DB objet.
    # db.exec(sql) - no longer required
    @id = db.exec_prepared("save_as", values)[0]['id'].to_i #PG gem gives you everything in an array RETURNING id. PG gem gives everything as string.
    #combining DB writing and id returning into one statement
    #Close DB Connection

    db.close()
  end

  def update
    db = PG.connect( { dbname: 'properties', host: 'localhost'})
    sql = "Update properties SET (
    address,
    value,
    number_of_bedrooms,
    year_built,
    status,
    square_footage,
    build_type
    ) = (
      $1, $2, $3, $4, $5, $6, $7
      ) WHERE id = $8
      "
      values = [@address, @value, @number_of_bedrooms, @year_built, @status, @square_footage, @build_type, @id]#order must always match!
      db.prepare("update", sql ) #PREPARED STATEMENT, BREAK SQL INJECTION ATTACK
      #execute SQL on DB object. SQL instruction  passed as a parameter and executed on DB objet.
      # db.exec(sql) - no longer required
      db.exec_prepared("update", values)
      #combining DB writing and id returning into one statement
      #Close DB Connection
      db.close()
    end

    def delete
      db = PG.connect( { dbname: 'properties', host: 'localhost'})
      sql = "DELETE FROM properties WHERE id = $1"
      values = [@id]
      db.prepare("delete_one", sql)
      db.exec_prepared("delete_one", values)
      db.close()
    end

    def Property.delete_all()
      db = PG.connect( { dbname: 'properties', host: 'localhost'})
      sql = "DELETE FROM properties"
      db.prepare("delete_all", sql)
      db.exec_prepared("delete_all")
      db.close()
    end

    def Property.find_by_id(id) #this is a class method
      #connect to DB. Ask PG to connect, return a DB object.
      db = PG.connect( { dbname: 'properties', host: 'localhost'})
      #Define SQL - USE DOUBLE QUOTES HERE AS SQL WITHIN WILL USE SINGLE AROUND INTERPOLATED STRINGS
      sql = "SELECT * FROM properties WHERE id = #{id}"
      db.prepare("find_by_id", sql ) #PREPARED STATEMENT, BREAK SQL INJECTION ATTACK
      #execute SQL on DB object. SQL instruction  passed as a parameter and executed on DB objet.
      property = db.exec_prepared("find_by_id")#does the execution and gives us a PG object - array of hashes - think pet example

      db.close()
      return property.map{|property_hash| Property.new(property_hash)} #this then maps the result, converting to new pizza object - otherwise a PG object which needs translated

    end


    def Property.find_our_address(address)
      db = PG.connect({dbname: 'properties', host: 'localhost'})
      sql = "SELECT * from properties WHERE address = $1"
      values = [address]
      db.prepare("find_by_address", sql)
      results_array = db.exec_prepared("find_by_address", values)
      db.close()
      new_array = results_array.map{|result| result}
      binding.pry
      if new_array.length == 0
        return nil
      else
        property_hash = results_array[0]
        found_property = Property.new(property_hash)
        return found_property
      end
    end

    # Codeclan solutions
    # def Property.find_by_address(address)
    #   db = PG.connect({dbname: 'properties', host: 'localhost'})
    #   sql = "SELECT * from properties WHERE address = $1"
    #   values = [address]
    #   db.prepare("find_by_address", sql) #prepare SQL for execution
    #   results_array = db.exec_prepared("find_by_address", values) #postgres returns an array of strings
    #   db.close()
    #   property_hash = results_array[0]
    #   found_property = Property.new(property_hash)
    #   return found_property

  #  end
  end   #class end
