class SubscribersController < ApplicationController

  before_action :authenticate_user!

  def new
  end

  def update
    token = params[:stripeToken]

    customer = Stripe::Customer.create(
        card: token,
        plan: 1020,
        email: current_user.email
    )
    current_user.subscribed = true
    current_user.stripeid = customer.id
    current_user.save

    redirect_to projects_path

  end
end
