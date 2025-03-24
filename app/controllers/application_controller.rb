class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include SessionsHelper, ApplicationHelper

  private

  def logged_in_user
    return if logged_in?

    render "sessions/new", status: :unauthorized
  end

  def logged_in_user!
    return if logged_in?

    flash[:error] = "You need to log in to access this page!"
    redirect_back_or_to root_url
  end

  def very_secure_current_council_filter
    unless user_in_current_council?
      flash[:error] = "You are not allowed to access this page!"
      redirect_back_or_to root_url
    end
  end
end
