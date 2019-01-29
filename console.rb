# #Codeclan Week 03 Day 02
# Pizza Shop Codealong
# Ruby, Databases and their interactions
# Console file - equivalent to a runner
# There is no testing for databases on this course - can look into elsewhere.

require_relative('models/property')
require('pry')

Property.delete_all()

property_1 = Property.new(
  {
'address' => '24 Button Moon Street',
'value' => 200000,
'number_of_bedrooms' => 3,
'year_built' => 1992,
'status' => 'Buy',
'square_footage' => 125.5,
'build_type' => 'Semi-detached'
}
)

property_2 = Property.new(
  {
'address' => '33 Bit Lane',
'value' => 150_000, #underscore can be used to separate integers for ease  - RUBY ONLY
'number_of_bedrooms' => 2,
'year_built' => 2005,
'status' => 'Buy',
'square_footage' => 80.2,
'build_type' => 'Apartment'
}
)

property_3 = Property.new(
  {
'address' => '546A Sun Crescent',
'value' => 600,
'number_of_bedrooms' => 1,
'year_built' => 1982,
'status' => 'Rent',
'square_footage' => 55,
'build_type' => 'Apartment'
}
)

property_4 = Property.new(
  {
'address' => 'Codeclan CEO House',
'value' => 1_000_000,
'number_of_bedrooms' => 8,
'year_built' => 2014,
'status' => 'Buy',
'square_footage' => 250.1,
'build_type' => 'Detached'
}
)

property_5 = Property.new(
  {
'address' => '34A Slum Village',
'value' => 250,
'number_of_bedrooms' => 1,
'year_built' => 1971,
'status' => 'Rent',
'square_footage' => 30,
'build_type' => 'Apartment'
}
)

property_1.save()
property_2.save()
property_3.save()
property_4.save()
property_5.save()

# property_4.value = 1_250_000
# property_4.update()
#
# property_5.delete
p Property.find_by_id(1) #use class method rather than an instance method
 p Property.find_by_address('Codeclan CEO House')
Property.find_by_address('ficticious')
