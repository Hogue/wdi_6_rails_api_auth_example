# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# %w(and dan dna) —> creates an array
# .each do |name| —>
%w(and dan dna).each do |name|
  # this generates a unique email address out of
  # the three strings contained in the arrray
  # (and, dan, dna)
  email = "#{name}@example.com"
  # if a user exists with this email
  # it skips to the next iteration
  next if User.exists? email: email
  User.create!(email: email,
               password: 'abc123',
               password_confirmation: nil)

end
