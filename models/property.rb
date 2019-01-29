# #Codeclan Week 03 Day 02
# Pizza Shop Codealong
# Ruby, Databases and their interactions
# Console file - equivalent to a runner
# There is no testing for databases on this course - can look into elsewhere.

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


end   #class end
