module SessionsHelper
  def log_in(username)
    session[:username] = username
    Sentry.set_user({
      username: username
    })
  end

  def current_user
    if session[:username]
      Sentry.set_user({
        username: session[:username]
      })
    end

    session[:username]
  end

  def logged_in?
    !session[:username].nil?
  end

  def log_out
    session.delete(:username)
    Sentry.set_user({})
  end

  def current_user?(username)
    username == session[:username]
  end
end
