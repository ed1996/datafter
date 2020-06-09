class SubscribersController < ApplicationController

  before_action :authenticate_user!
  before_action :add_breadcrumbs_list_hommages
  before_action :add_breadcrumbs_hommages
  add_breadcrumb "Paiement", :subscribers_path

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
        plan: "price_1Grh5OG6VjaT54O4p1EgxfK3",
        email: current_user.email
    )
    current_user.subscribed = true
    current_user.stripeid = customer.id
    current_user.save

    redirect_to root_path

  end
end
