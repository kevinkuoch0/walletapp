class CardsUserIdToOwnerId < ActiveRecord::Migration
  def change
  	change_column :cards, :user_id, :card_owner_id
  end
end
