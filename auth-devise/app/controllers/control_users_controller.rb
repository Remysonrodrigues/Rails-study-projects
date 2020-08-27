class ControlUsersController < ApplicationController
  def index
    @users = User.all
  end
end
