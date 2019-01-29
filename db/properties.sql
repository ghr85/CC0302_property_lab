-- # #Codeclan Week 03 Day 02
-- # Pizza Shop Codealong
-- # Ruby, Databases and their interactions
-- # Console file - equivalent to a runner
-- # There is no testing for databases on this course - can look into elsewhere.

DROP TABLE IF EXISTS properties;

CREATE TABLE properties (
  id SERIAL8 PRIMARY KEY,
  address VARCHAR(255),
  value INT8,
  number_of_bedrooms INT8,
  year_built INT8,
  status VARCHAR(255),
  square_footage FLOAT4,
  build_type VARCHAR(255)
);
