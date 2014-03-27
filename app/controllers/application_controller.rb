class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :set_layout
  before_filter :set_format

  def set_format
    request.format = :iphone if iphone_request?
    request.format = :android if android_request?
  end

  def set_layout
    return "mobile" if (iphone_request? || android_request?)
    return "application"
  end

  private
  def iphone_request?
    request.user_agent =~ /(Mobile.+Safari)/
  end

  private
  def android_request?
    request.user_agent =~ /(Android)/
  end
end
