class ApplicationController < ActionController::Base
  before_action :current_user

  helper_method :current_user
end
