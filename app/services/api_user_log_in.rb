class ApiUserLogIn

  attr_reader :user

  def initialize(email, password)
    @password = password
    @user = User.find_by_email(email)
  end

  def valid?
    @user && @user.valid_password?(@password)
  end

  def login_user
    @user.update(api_token: SecureRandom.uuid, api_last_activity: DateTime.now, last_sign_in_at: DateTime.now)
  end

end