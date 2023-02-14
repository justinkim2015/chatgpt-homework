class UsersController < ApplicationController
  before_action :check_admin

  def index
    @users = User.all
  end

  private 

  def check_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end
end
