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

  def very_secure_current_council_filter
    unless current_user.in? [
      "cschuijt", "avaliull", "llourens", "oriabenk", "amel-fou",
      "mshulgin", "kiwong", "aleseile", "mde-beer", "mnijsen", "roversch"
    ]
      flash[:error] = "You are not allowed to access this page!"
      redirect_to root_url
    end
  end
end
