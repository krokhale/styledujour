#Include the HTML class

namespace :skimlinks do
  desc "Import Skimlinks Data"
  task :import => :environment do
    load 'lib/skimlinks.rb'
    products = Skimlinks::Products.new "134622cd7b1408df3185cd4b047202be"
    products.products
    
  end
end