class CardsController < ApplicationController

	def index
		
	end

	def edit
		@card = Card.find(params[:id])
	end

	def show
		@card = Card.find(params[:id])
	end

	def new
		@card = Card.new
	end

	def create
		@card = Card.new(cardparams.merge(card_owner_id: current_user.id))
		if @card.save
			current_user.cards << @card
			redirect_to user_path(current_user.id)
			flash[:notice] = "Card has been saved!"
		else
			flash[:alert] = "Card was not saved successfully."
			render :new
		end
	end

	def update
		@card = Card.find(params[:id])
		if @card.update(cardparams)
			redirect_to root_path, notice: "Card updated!"
		else
			flash[:alert] = "Card was not udpated."
			render :edit
		end
	end

	def share
		@card = Card.find(params[:id])
		@shared_user = User.find_by(email: params[:email])
		if !@shared_user.has_card?(@card.id)
			@shared_user.cards << @card
			flash[:notice] = "Card shared with #{@shared_user.full_name}."
			render :show
		else
			flash[:alert] = "Cannot complete request. You are already sharing this card with #{@shared_user.full_name}."
			render :show
		end
	end	

	def remove
    	UserCard.where(user_id: current_user.id, card_id: params[:id]).first.destroy
    	redirect_to root_path, notice: "Card removed."
  	end

  	def destroy
    	@card = Card.find(params[:id])  	
   	 	if @card.destroy
	      redirect_to root_path, notice: "Card deleted."
	    else
	      flash[:alert] = "Something went wrong."
	      render :edit
		end
  	end

	private

	def cardparams
		params.require(:card).permit(:cardnumber, :cardtype, :expmonth, :expyear, :balance)
	end
end