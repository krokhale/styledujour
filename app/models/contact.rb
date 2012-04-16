# == Schema Information
#
# Table name: contacts
#
#  id          :integer         not null, primary key
#  sender_id   :integer
#  receiver_id :integer
#  inverse_id  :integer
#  ties_count  :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Contact < ActiveRecord::Base
end
