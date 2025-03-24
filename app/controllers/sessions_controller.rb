class SessionsController < ApplicationController
  before_action :logged_in_user,    only: :destroy
  before_action :already_logged_in, only: :create

  # Creates a session cookie, adds the user to the database if they do not
  # exist yet, then redirects them to the root url.
  def create
    auth = request.env["omniauth.auth"]

    # Disallow students from other campuses from logging in or casting votes
    unless auth.extra.raw_info.campus.any? { |campus| campus.id == (ENV["CAMPUS_ID"]&.to_i || 14) } # Codam's ID is 14
      flash[:error] = "Only students belonging to this campus are able to vote."

      redirect_to request.env["omniauth.origin"] || root_url
      return
    end

    log_in(auth.info.login)

    flash[:info] = "Successfully logged in."

    redirect_to request.env["omniauth.origin"] || root_url
  end

  # Destroys the session cookie and logs the user out.
  def destroy
    log_out

    flash[:info] = "Successfully logged out."
    redirect_back_or_to root_url
  end

  # Endpoint reached when something goes wrong during OAuth
  def failure
    flash[:warning] = "Login was unsuccessful, please try again!"
    redirect_back_or_to root_url
  end

  private

  def already_logged_in
    return unless logged_in?

    flash[:warning] = "You are already logged in!"
    redirect_back_or_to request.env["omniauth.origin"] || root_url
  end
end
