class UserCardsController < ApplicationController
  before_action :set_user_card, only: [:show, :edit, :update, :destroy]

  # GET /user_card
  # GET /user_card.json
  def index
    @user_cards = UserCard.all
  end


  def show
  end


  def new
    @user_card = UserCard.new
  end


  def edit
  end


  def create
    @user_card = UserCard.new(user_card_params)

    respond_to do |format|
      if @user_card.save
        format.html { redirect_to @user_card, notice: 'User card was successfully created.' }
        format.json { render :show, status: :created, location: @user_card }
      else
        format.html { render :new }
        format.json { render json: @user_card.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @user_card.update(user_card_params)
        format.html { redirect_to @user_card, notice: 'User card was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_card }
      else
        format.html { render :edit }
        format.json { render json: @user_card.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @user_card.destroy
    respond_to do |format|
      format.html { redirect_to user_cards_url, notice: 'Users card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
   
    def set_user_card
      @user_card = UserCard.find(params[:id])
    end

   
    def user_card_params
      params.require(:user_card).permit(:user_id, :card_id)
    end
end
