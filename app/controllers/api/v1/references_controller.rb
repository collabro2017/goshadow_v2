module Api
  module V1
    class ReferencesController < ApiBaseController

      before_filter :find_user

      def index
        @references = ApiDataGrab::References.run(@user)
        render json: @references, status: 200, root: false
      end

      def create
        @reference = Reference.find_or_initialize_by(reference_params)
        add_created_by_id
        if @reference.save
          ReferenceSegment.find_or_create_by(reference_id: @reference.id, segment_id: params['reference']['segment_id'])
          render json: @reference, status: 200, root: false, serializer: ReferenceSerializer
        else
          render json: api_errors(@reference), status: 401, root: false
        end
      end

      private

      def add_created_by_id
        if @reference.created_by_id.nil?
          @reference.created_by_id = @user.id
        end
      end

      def reference_params
        params.require(:reference).permit(:organization_id, :name, :type, :created_by_id)
      end

    end
  end
end