class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:password_digest] = user.password_digest
      redirect_to root_url, :notice => "Logged in!"
    else
      # flash.now.notice = "Invalid email or password"
      render :json  => [:login => :invalid]
      # redirect_to root_url, :notice => "Incorrect email or password"
    end
  end
  
  def destroy
    session[:password_digest] = nil
    redirect_to root_url
  end

end
