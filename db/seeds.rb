# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Point.find_or_create_by_action(:action=>"HCIT_add_clothing_item", :value=>1, :description=>"added a clothing item to ask How Cute Is This?", :repeatable=>true)
Point.find_or_create_by_action(:action=>"HCIT_score_clothing_item", :value=>2, :description=>"scored a clothing item on How Cute Is This?", :repeatable=>true)