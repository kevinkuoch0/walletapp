class Card < ActiveRecord::Base

		validates_presence_of :cardnumber, :expmonth, :expyear 

	  validates_numericality_of :expmonth, only_integer: true

	  validates_numericality_of :cardnumber, only_integer: true

	  validates_numericality_of :expyear, only_integer: true

	  validates :cardnumber, length: {in: 15..16}

	  validates :expmonth, inclusion: {in: 1..12, message: " not a valid month. Please enter a 1 or 2 digit month"}, length: {in: 1..2, message: " is not a valid month. Please enter a 1 or 2 digit month"}

	  validates :expyear, length: {is: 4, message: " is not a valid year. Please enter a 4 digit year"}

	  validates_numericality_of :expyear, greater_than_or_equal_to: 2015, :message => " is already expired. Please enter a valid expiration year"
	  validate :valid_card_num

	  has_many :users, through: :user_cards
	  has_many :user_cards

	  before_save :card_type_check

		def card_type_check
		if self.cardnumber.starts_with?("37")
			self.cardtype =  "American Express"
		elsif self.cardnumber.starts_with?("38")
			self.cardtype = "Diners Club"
		elsif self.cardnumber.starts_with?("4")
			self.cardtype = "Visa"
		elsif self.cardnumber.starts_with?("5")
			self.cardtype = "MasterCard"
		elsif self.cardnumber.starts_with?("6")
			self.cardtype = "Discover"
		else
			self.cardtype = "Undefined Travel Card"
		end
	end

	def cardnumber_display
		if self.cardnumber.starts_with?("3")
			self.cardnumber.gsub(/(.{4})(.{6})(?=.)/, '\1 \2 ')
		elsif self.cardnumber.starts_with?("4","5","6")
			self.cardnumber.gsub(/(.{4})(?=.)/, '\1 \2')
		else
			self.cardnumber
		end
	end

	private

	def valid_card_num
		errors.add(:cardnumber, " is not a valid debit card type. Please double-check the card number") unless cardnumber.start_with?('3', '4', '5', '6')
	end


end
