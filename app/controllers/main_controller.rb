class MainController < ApplicationController
  def index
    respond_to do |format|
      format.html
      
      # binding.pry
      format.js do
        if current_user
          render :js => "$('#loginContainer').hide();  $('#loggedInContainer').fadeIn(500);"
        else
          render :js => "$('#loggedInContainer').hide();  $('#loginContainer').fadeIn(500);"
        end
      end
    end
  end

end
