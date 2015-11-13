class User < ActiveRecord::Base

validates_presence_of :email, :fname, :lname

has_secure_password

validates_presence_of :password, on: :create

validates :email, uniqueness: true

validates :password, length: { minimum: 4 },
confirmation: true

validates :phone, format: { with: /\d{3}-\d{3}-\d{4}/, message:" format must be xxx-xxx-xxxx"}

has_many :cards, through: :user_cards
has_many :user_cards


def full_name
	if !fname.empty? && !lname.empty?
		fname.capitalize+" "+lname.capitalize
	elsif !fname.empty?
		fname.capitalize
	elsif !lname.empty?
		lname.capitalize
elsif fname.empty? && lname.empty?
  username
	end
end

def has_card?(card_id)
cards = user_cards.collect {|f| f.card_id}
cards.include?(card_id)
end


end
