class PurchasesController < ApplicationController

  def new
  end

  def create
    token = params[:stripeToken]
    begin
      charge = Stripe::Charge.create(
        amount: 999,
        currency: 'usd',
        source: token,
        description: "Example charge"
      )
      flash[:success] = "Your card was successfully charged!"
      redirect_to root_path
    rescue Stripe::CardError => e
      flash[:danger] = e.message
      render :new
    end
  end

  def purchase_with_presspass
    presspass_token = params[:presspassToken]

    stripe_token = redis.hget(presspass_token, "stripeToken")
    binding.pry
    begin
      charge = Stripe::Charge.create(
        amount: 999,
        currency: 'usd',
        source: stripe_token,
        description: "Example charge"
      )
      flash[:success] = "Your card was successfully charged!"
      redirect_to root_path
    rescue Stripe::CardError => e
      flash[:danger] = e.message
      render :new
    end
  end


  private

  def redis
    Redis.current
  end 


end
