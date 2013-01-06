#coding: utf-8

module Helpers
  def warden
    env['warden']
  end

  def oauth_token
    token = env['HTTP_AUTHORIZATION'] || ""
    token.split(" ").last
  end

  # user helpers
    def current_user
      token = params[:token] || oauth_token
      unless token.blank?
        # @current_user ||= User.where(:private_token => token).first
      end
    end

    def authenticate!
      # error!({ "error" => "401 Unauthorized" }, 401) unless current_user
    end
end
