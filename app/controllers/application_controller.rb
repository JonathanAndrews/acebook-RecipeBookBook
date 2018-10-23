# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  unless ENV['RAILS_ENV'] == 'test'
    before_action :authenticate_user!
  end

end
