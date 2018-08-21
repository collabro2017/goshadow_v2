class AdminController < ApplicationController

  before_filter :authenticate_user!, :system_admin?

  def index
    @organizations = Organization.all
  end

  private

  def system_admin?
    not_found unless current_user.system_admin
  end

end