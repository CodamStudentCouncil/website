class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include SessionsHelper

  private

  def logged_in_user
    return if logged_in?

    flash[:error] = "You need to log in to access this page!"
    redirect_to root_url
  end
end
