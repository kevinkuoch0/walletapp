module ApplicationHelper

# LOOK AT THE USERS CONTROLLER. User.id is now being set to something called session[:id], which we use for this action to create a user session.

  # if session[:id]
  # 	User.find(session[:id])
  # else
  # 	nil
  # end

  def current_user
  	session[:id] ? User.find(session[:id]) : nil
  end

  def shared_name(card_owner_id)
  	User.find(card_owner_id).full_name
  end



end
