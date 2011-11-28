class SessionsController < ApplicationController
  
  respond_to :html, :js, :json
  
  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:password_digest] = user.password_digest
      
      respond_with do |format|
        format.html { redirect_to root_url, :notice => "Logged in!" }
        format.js { render :json => [:login => :valid] }
      end
      
    else
      
      respond_with do |format|
        format.html { redirect_to root_url, :notice => "Invalid login!" }
        format.js { render :json => [:login => :invalid] }
      end
      
      # flash.now.notice = "Invalid email or password"
      # render :json => [:login => :invalid]
      # redirect_to root_url, :notice => "Incorrect email or password"
    end
  end
  
  def destroy
    session[:password_digest] = nil
    redirect_to root_url
  end

end
