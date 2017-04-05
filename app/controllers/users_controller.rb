class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @user_object = Supports::ShowUser.new @user
  end
end
