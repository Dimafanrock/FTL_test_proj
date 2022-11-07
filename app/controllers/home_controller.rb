class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:homepage]
 
  def public_page
    @purchases = current_user.purchases    
  end


end
