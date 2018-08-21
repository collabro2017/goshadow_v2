module Api
  module V1
    class NotesController < ApiBaseController

      before_filter :find_user

      def create
        @note = Note.new(note_params)
        @note.user_id = @user.id
        if @note.save
          save_image
          render json: @note, status: 200, root: false
        else
          render json: api_errors(@note), status: 401
        end
      end

      def update
        @note = Note.find(params['id'])
        if @note.update(note_params)
          save_image
          render json: @note, status: 200, root: false
        else
          render json: api_errors(@note), status: 401, root: false
        end
      end

      def destroy
        @note = Note.find(params['id']) rescue false
        if @note
          @note.destroy
          render nothing: true, status: 200
        else
          render nothing: true, status: 404
        end
      end

      private

      def note_params
        params.require(:note).permit(:text, :reference_id, :segment_id, :text, :start_time, :seconds, :status, :created_at, :user_id)
      end

      def save_image
        if params['note']['attachment_data']
          attachment_data = StringIO.new(Base64.decode64(params['note']['attachment_data']))
          attachment_data.class.class_eval { attr_accessor :original_filename, :content_type }
          attachment_data.original_filename = (SecureRandom.urlsafe_base64 + '.png')
          attachment_data.content_type = 'image/png'
          params['note']['attachment_url'] = attachment_data
          note_image = NoteImage.create(attachment: attachment_data)
          note_image.update(assetable_id: @note.id, assetable_type: 'Note')
        end
      end

    end
  end
end