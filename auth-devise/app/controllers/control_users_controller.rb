class ControlUsersController < ApplicationController
  def index
    @users = User.all
    authorize @users
  end
end
