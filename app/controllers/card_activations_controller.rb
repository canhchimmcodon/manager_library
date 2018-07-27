class CardActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.card_activated? &&
       user.authenticated?(:card_activation, params[:id])
      card = user.build_card
      process_for_card card, user
    else
      flash[:danger] = t ".invalid_link"
    end
    redirect_to root_url
  end

  def process_for_card card, user
    if card.save
      user.update_attributes card_activated: true
      flash[:success] = t ".card_activated"
    else
      flash[:danger] = t ".failed_create_card"
    end
  end
end
