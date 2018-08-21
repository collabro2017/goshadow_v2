module Api
  class ApiBaseController < ApplicationController

    skip_before_filter  :verify_authenticity_token
    API_TOKEN_EXPIRE = 15.days

    def find_user
      authenticate_or_request_with_http_token do |token, options|
        @user = User.find_by_api_token(token)
        if @user.nil?
          render json: 'Invalid Token', status: 401
        elsif invalid_token?
          render json: 'Invalid Token', status: 401
        else
          @user.update(api_last_activity: Date.today)
          return true
        end
      end
    end

    private

    def invalid_token?
      @user.api_last_activity < 15.days.ago
    end

  end
end