class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  before_action :hi


  private


  def hi
    p "@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      
  end

end
