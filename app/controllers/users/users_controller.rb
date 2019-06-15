class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def avatarDestroy
    @user = User.find(params[:id])
    user = @user.user

    @user.user.avatar = nil

    @user.update

    respond_to :js
  end

end
