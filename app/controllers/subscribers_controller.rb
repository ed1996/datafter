class SubscribersController < ApplicationController

  before_action :authenticate_user!

  def index
  end

  def new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    token = params[:stripeToken]

    customer = Stripe::Customer.create(
        card: token,
        plan: 2030,
        email: current_user.email
    )
    current_user.subscribed = true
    current_user.stripeid = customer.id
    current_user.save

    redirect_to root_path

  end
end
