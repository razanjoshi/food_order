class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include ApplicationHelper

  def current_user
    super || guest_user
  end


  def guest_user
    User.find(session[:guest_user_id].nil? ? session[:guest_user_id] = continue_as_guest.id : session[:guest_user_id])
  end

  def continue_as_guest
    user = User.find_or_create_by(email: 'guest@cafe.com')
    user.save(:validate => false)
    user
  end
end
