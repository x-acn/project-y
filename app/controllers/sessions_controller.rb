class SessionsController < ApplicationController
  
  respond_to :html, :js
  
  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:password_digest] = user.password_digest
      respond_with do |format|
        format.html { redirect_to root_url, :notice => "Logged in!" }
        format.js { render :json => [:login => :valid, :user => user.email ] }
      end
    else
      respond_with do |format|
        format.html { redirect_to root_url, :notice => "Invalid login!" }
        format.js { render :json => [:login => :invalid] }
      end
    end
  end
  
  def destroy
    session[:password_digest] = nil
    respond_with do |format|
      format.html { redirect_to root_url, :notice => "Logged out!" }
      format.js { render :json => [:logout => :valid] }
    end
  end

end
