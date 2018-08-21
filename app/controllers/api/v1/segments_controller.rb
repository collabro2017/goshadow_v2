module Api
  module V1
    class SegmentsController < ApiBaseController

      before_filter :find_user

      def create
        @segment = Segment.new(segment_params)
        @segment.created_by_id = @user.id
        if @segment.save
          @user.add_to_segment(@segment)
          render json: @segment, status: 200, serializer: nil
        else
          render json: api_errors(@segment), status: 401
        end
      end

      def update
        @segment = Segment.find(params['id'])
        if @segment.update(segment_params)
          render json: @segment, status: 200
        else
          render json: api_errors(@segment), status: 401, root: false
        end
      end

      def destroy
        @segment = Segment.find(params['id']) rescue false
        if @segment
          @segment.archive
          render nothing: true, status: 200
        else
          render nothing: true, status: 404
        end
      end

      private

      def segment_params
        params.require(:segment).permit(:experience_id, :name, :start_location, :end_location)
      end

    end
  end
end