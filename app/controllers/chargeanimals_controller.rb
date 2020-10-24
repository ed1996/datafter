class ChargeanimalsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    # Amount in cents
    @amount = 500

    # get customer from POST params
    customer = Stripe::Customer.create(
        email: params[:stripeEmail],
        source: params[:stripeToken]
    )

    begin
      charge = Stripe::Charge.create(
          customer: customer.id,
          amount: @amount,
          description: 'Hommage pour un animal',
          currency: 'eur'
      )
      current_user.update_attribute(:subscribed, true)
      current_user.update_attribute(:stripeid, customer.id)
      redirect_to new_animal_path
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end
  end
end
