class Presspass::PresspassController < ApplicationController

  protect_from_forgery with: :null_session

  APN = Houston::Client.development

  APN.certificate = File.read("#{Rails.root}/config/apple_push_notification.pem")

  def sign_in

    user = User.find_by(email: params[:email])
    url = params[:url]

    notification = Houston::Notification.new(device: user.device_token)
    notification.alert = "Slide to log in to #{url}"
    notification.sound = "default"
    notification.custom_data = {url: url, type: "login"}

    APN.push(notification)
    render nothing: true
  end

  def create_token
    user = User.find_by(email: params[:email])

    if user && user.device_token == params[:deviceToken]
      presspass_token = SecureRandom.urlsafe_base64

      redis.pipelined do
        redis.set(user.email, presspass_token)
        redis.expire(user.email, 60)
      end
    end
    
    # Add success check
    render nothing: true
  end

  def get_token
    token = redis.get(params[:email])
    render json: {
      token: token
    }
  end


  def purchase
    user = User.find_by(email: params[:email])
    url = params[:url]

    notification = Houston::Notification.new(device: user.device_token)
    notification.alert = "Slide to purchase"
    notification.sound = "default"
    notification.custom_data = {type: "purchase", url: url}

    APN.push(notification)
    render nothing: true
  end

  def create_purchase_token
    user = User.find_by(email: params[:email])

    if user && user.device_token == params[:deviceToken]
      presspass_token = SecureRandom.urlsafe_base64

      redis.pipelined do
        redis.set(user.email, presspass_token)
        redis.expire(user.email, 60)
        redis.hset(presspass_token, "stripeToken", params[:stripeToken])
        redis.hset(presspass_token, "shippingName", params[:shippingName])
        redis.hset(presspass_token, "shippingStreet", params[:shippingStreet])
        redis.hset(presspass_token, "shippingCity", params[:shippingCity])
        redis.hset(presspass_token, "shippingState", params[:shippingState])
        redis.hset(presspass_token, "shippingZip", params[:shippingZip])
        redis.expire(presspass_token, 60)
      end
    end
      render nothing: true

  end

  private

  def redis
    Redis.current
  end

end