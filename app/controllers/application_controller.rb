class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def require_access_token
      # puts "params: #{params}"
      # puts "user: #{User.find_by("access_token", params["access_token"])}"
      # puts "users: #{User.all.to_a}"
      if params.include?("access_token") && User.find_by(access_token: params["access_token"])
        # puts "found access_token"
        session[:access_token] = params["access_token"]
      else
        puts "params.include: #{params.include?('access_token')}"
        puts "access_token: #{params['access_token']}"
        puts "user? #{User.find_by(access_token: params['access_token'])}"
        puts "users: #{User.all.to_a}"
        render json: {status: "unauthorized"}, status: 401
      end
    end

    def current_user
      return unless session[:access_token]
      @current_user ||= User.find_by(access_token: session[:access_token])
    end
end
