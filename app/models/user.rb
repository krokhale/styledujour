# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  name                   :string(255)
#  uid                    :string(255)
#  provider               :string(255)
#  token                  :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#

class User < ActiveRecord::Base
# Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :token, :name
  has_and_belongs_to_many :bookmarks, :class_name=> "ClothingItem", :join_table => "user_bookmarked_clothing_items", :foreign_key => "user_id" 
  has_many :user_asked_clothing_items
  has_many :user_bookmarked_clothing_items
  has_many :hcit_items, :through => :user_asked_clothing_items, :source => :clothing_item
  has_many :scores, :class_name => "UserScoredClothingItem"
  has_many :scorered_items, :through => :user_scored_clothing_items, :class_name => "ClothingItem", :source=>:clothing_item
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first  ## TODO: what about existing users with a different facebook email?
      user.update_attributes(:token => access_token.credentials.token)
      user
    else
      User.create!(new_user_params(access_token, "facebook"))
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"]
        user.email = data["email"]
        user.provider = data["provider"]
        user.uid = data["uid"]
        user.token = data["credentials"]["token"] if data["credentials"]["expires"] == false
        user.name = data["user_info"]["name"]
      end
    end
  end
  
  def self.new_user_params(access_token, provider)
    logger.debug access_token.inspect
    email,uid,token,name = nil
    case provider
    when "facebook"
        email = access_token.extra.raw_info.email
        provider = access_token.provider
        uid = access_token.uid
        token = access_token.credentials.token
        name = access_token.info.nickname
    end

      

    {:email=>email,:provider=>provider,:uid=>uid,:token=>token,:name=>name,:password=>Devise.friendly_token[0,20]}
  end
end
