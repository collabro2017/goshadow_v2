module Api
  module V1
    class ExperiencesController < ApiBaseController

      before_filter :find_user

      def index
        @api_data_grab = ApiDataGrab::Experiences.new(@user)
        @experiences = @api_data_grab.run
        render json: @experiences, status: 200, root: false
      end

      def create
        @experience = Experience.create(experience_params)
        @experience.created_by_id = @user.id
        if @experience.save
          @user.add_to_experience(@experience)
          render json: @experience, status: 200, serializer: nil
        else
          render json: api_errors(@experience), status: 401, root: false
        end
      end

      def update
        @experience = Experience.find(params['id'])
        if @experience.update(experience_params)
          render json: @experience, status: 200, serializer: nil
        else
          render json: api_errors(@experience), status: 401, root: false
        end
      end

      def destroy
        @experience = Experience.find(params['id']) rescue nil
        if @experience
          @experience.archive
          render nothing: true, status: 200
        else
          render nothing: true, status: 404
        end
      end

      private

      def experience_params
        params.require(:experience).permit(:organization_id, :name, :description, :location, :published)
      end
      
    end
  end
end