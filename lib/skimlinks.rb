
module Skimlinks
  class SkimlinksBase
    include HTTParty
    base_uri 'http://api-product.skimlinks.com'
    
    def initialize(key)
      @key = key
    end
    
    def gets(location,options={})
      location << "&key=#{@key}"
      self.class.get(location, options)
    end
  end
  
  class Categories < SkimlinksBase
    def get()
      results = JSON.parse(gets('/categories?format=json').body)
      output = []
      results["skimlinksProductAPI"]["categories"].each do | category|
        output << {:id=>category[0], :name=>category[1]} if category[1].include?("Apparel")
      end
      
      return output
    end
  end
  
  class Products < SkimlinksBase
    def get_product(id)
      results = JSON.parse(gets("/query?format=json&q=productId%3A#{CGI.escape(id)}").body)
    end
    
    def self.create(category, product)
      manufacturer = Manufactorer.find_or_create_by_name(product["manufacturer"]) unless product["manufacturer"].empty?
      retailer = Retailer.find_or_create_by_name(product["merchant"])
      group = Group.find_by_slug(retailer.name.to_url)
      if group.nil?
        group = Group.create!(:name=>retailer.name, :author_id=>Actor.first, :user_author_id=>Actor.first)
      end
      price = BigDecimal.new(product["price"]) / BigDecimal.new("100")
      gender = product["categorisation"]["categoryGender"] == "female" ? 0 : 1
      
      aff = AffiliateClothingItem.by_skimlinks(product["productId"]).first
      
      if aff
        return
      else
        aff = AffiliateClothingItem.new(:skimlinks_product_id=>product["productId"],
          :description=>product["description"], :name=>product["title"], :price=>price, :manufacturer=>manufacturer,
          :gender=>gender, :category_id=>category.id, :item_url => product["url"], :imageurl => product["imageUrl"],
          :currency => product["currency"], :sku=>product["identifiers"]["sku"], :mpn=>product["identifiers"]["mpn"],
          :upc=>product["identifiers"]["upc"], :is_accessory=>product["isAccessory"], :skimlinks_group_id=>product["groupId"])
          aff.set_ownership(group.actor, group.actor.id, group.actor.id)
        aff._relation_ids = Array.wrap Relation::Public.instance.id  
        aff.save!
        retailer.clothing_items << aff.clothing_item unless retailer.clothing_items.find(:first, :conditions=>["clothing_items.id = ?", aff.clothing_item.id])
        manufacturer.clothing_items << aff.clothing_item if manufacturer && manufacturer.clothing_items.find(:first, :conditions=>["clothing_items.id = ?", aff.clothing_item.id])
      end
    end
    
    def products
      Category.roots.each do |root|
        root.children.each do |category|
          
          
          current_position = 0
          count = 1
          while count > current_position 
            results = JSON.parse(gets("/query?format=json&q=categoryId%3A#{category.source_identifier}&rows=300&start=#{current_position}").body)
            current_position += 300
            if results["skimlinksProductAPI"]["products"]
              results["skimlinksProductAPI"]["products"].each do |product|
                begin
                  Products.create(category,product)
                rescue Exception => e
                  Rails.logger.error(e.to_s)
                end
              end
            end
            count = results["skimlinksProductAPI"]["numFound"] || 0
          end
        end
      end
      
    end
  end
  
  class Generate
    
    def self.create_categories
      skm = Skimlinks::Categories.new "134622cd7b1408df3185cd4b047202be"
      results = skm.get
      results.each do |row|
        list = row[:name].split(">").map{|x| x.strip}
        top = nil
        list.each_with_index do |name,i|
          if i == 0
            next
          else
            top = Category.find_or_create_by_name(:name=>list[i],:parent_id => top.try(:id), :source=>"Skimlinks", :source_identifier=>row[:id].to_i)
          end
        end
      end
    end
    
  end
end