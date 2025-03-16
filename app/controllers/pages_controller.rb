class PagesController < ApplicationController
  def home
    if Rails.env.preprod? && flash.now[:info].blank?
      flash.now["info"] = "You are in the preproduction environment, running a development build. Some things may be broken, and changes you make will not affect the production environment."
    end
    render layout: "seamless"
  end

  def privacy
  end
end
