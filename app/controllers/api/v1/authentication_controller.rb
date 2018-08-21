module Api
  module V1
    class AuthenticationController < ApiBaseController

      before_filter :find_user, only: [ :signed_in_user ]

      def login
        @api_user_login = ApiUserLogIn.new(params['email'], params['password'])
        if @api_user_login.valid?
          @api_user_login.login_user
          render json: { token: @api_user_login.user.api_token }, status: 200
        else
          render json: { messages: [ 'Email or Password is Invalid' ] }, status: 401
        end
      end

      def signup
        @user = User.create(registration_params)
        if @user.save
          @api_user_login = ApiUserLogIn.new(params['user']['email'], params['user']['password'])
          @api_user_login.login_user
          render json: { token: @api_user_login.user.api_token }, status: 200
        else
          render json: api_errors(@user), status: 401, root: false
        end
      end

      def signed_in_user
        render json: @user, status: 200, root: false
      end

      def reset_password
        @user = User.find_by_email(params['email'])
        if @user.present?
          @user.send_reset_password_instructions
          render nothing: true, status: 200
        else
          render json: 'Could not find an account with email.', status: 401        
        end
      end

      private

      def registration_params
        params.require(:user).permit(:id, :first_name, :last_name, :email, :password, :password_confirmation, 
          user_organizations_attributes: [
            :user_id, :role, organization_attributes: [
              :name, :team_size
            ]
          ]
        )
      end

    end
  end
end

# TEST CALLS

#Sign In
# curl --data "email=joeshadower@goshadow.com&password=goshadow" http://0.0.0.0:3000/api/v1/authentication/login

# Sign Up

# curl -X POST -d user="{\"first_name\": \"API\", 
# \"last_name\":\"Shadower\",
# \"password\":\"stevedanko\",
# \"email\":\"joedanko@fake.com\",
# \"password_confirmation\":\"stevedanko\",
# \"user_organizations_attributes\": 
# {\"0\": 
#   {\"role\": \"admin\", \"organization_attributes\": 
#     {\"name\": \"steve\"}
#   }
# }}" https://guarded-savannah-53005.herokuapp.com/api/v1/authentication/signup

# Get signed_in_user

# curl http://0.0.0.0:3000/api/v1/authentication/signed_in_user -H 'Authorization: Token token="6f41af4f-ec19-4af4-ba48-23159df7dea1"'


# GET Organizations
# curl http://0.0.0.0:3000/api/v1/organizations -H 'Authorization: Token token="9f7286dd-cc60-4146-b27f-a92764db9f45"'

# GET References
# curl http://0.0.0.0:3000/api/v1/organizations/1/references -H 'Authorization: Token token="9f7286dd-cc60-4146-b27f-a92764db9f45"'

# curl -X POST --data reference='{"organization_id":"5","name": "Janitor","type": "Person"}' http://0.0.0.0:3000/api/v1/references -H 'Authorization: Token token="9f7286dd-cc60-4146-b27f-a92764db9f45"'

# GET Experiences
# curl http://0.0.0.0:3000/api/v1/experiences -H 'Authorization: Token token="11018184-159d-4ada-99c1-bfa710e37b14"'
# Delete Experience
# curl -X DELETE http://0.0.0.0:3000/api/v1/experiences/8 -H 'Authorization: Token token="9f7286dd-cc60-4146-b27f-a92764db9f45"'
# Update Experience
# curl -X PATCH --data experience='{"name":"test","description": "this is a expience from the api","location": "my desk at the beauty shoppe", "published": "false"}' http://0.0.0.0:3000/api/v1/experiences/1 -H 'Authorization: Token token="a95f9330-64de-4bc5-bd5b-e4505de06c62"'


# Update Note
# curl -X PATCH --data note='{"segment_id":"3","reference_id": "11","text": "note updated from the api", "seconds": "3333"}' http://0.0.0.0:3000/api/v1/notes/7 -H 'Authorization: Token token="9f7286dd-cc60-4146-b27f-a92764db9f45"'
# Create Note
# curl -X POST --data note='{"segment_id":"3","reference_id": "11","text": "note created from api", "seconds": "3333"}' http://0.0.0.0:3000/api/v1/notes -H 'Authorization: Token token="9f7286dd-cc60-4146-b27f-a92764db9f45"'
#Delete Note
# curl -X DELETE http://0.0.0.0:3000/api/v1/notes/7 -H 'Authorization: Token token="9f7286dd-cc60-4146-b27f-a92764db9f45"'


# Update Segment
# curl -X PATCH --data segment='{"name": "segment updated from the api", "start_location": "this is the start", "end_location": "this is the end"}' http://0.0.0.0:3000/api/v1/segments/4 -H 'Authorization: Token token="9f7286dd-cc60-4146-b27f-a92764db9f45"'
# Create Segment
# curl -X POST --data segment='{ "experience_id": "7", "name": "segment CREATED from the api", "start_location": "this is the start", "end_location": "this is the end"}' http://0.0.0.0:3000/api/v1/segments/ -H 'Authorization: Token token="9f7286dd-cc60-4146-b27f-a92764db9f45"'
#Delete Segment
# curl -X DELETE http://0.0.0.0:3000/api/v1/segments/25 -H 'Authorization: Token token="9f7286dd-cc60-4146-b27f-a92764db9f45"'
