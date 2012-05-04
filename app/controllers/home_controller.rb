class HomeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_session

  def index
  end
  
  private
  def check_session
    if cookies[:clothing_score]
      clothing_item = JSON.parse cookies[:clothing_score]
      if current_user.scorered_items.where(:id=>clothing_item["item"]).empty?
        score = UserScoredClothingItem.new
        score.user = current_user
        score.clothing_item = ClothingItem.find(clothing_item["item"])
        score.price = clothing_item["score"]
        score.love = clothing_item["love"]
        
        if score.save
           Point.award(current_user, "HCIT_score_clothing_item")
        end
      end
      cookies.delete :clothing_score
    end
  end
end