module Api
  module V1
    class OrganizationsController < ApiBaseController

      before_filter :find_user

      def index
        @organizations = @user.organizations
        render json: @organizations, status: 200, root: false
      end

    end
  end
end