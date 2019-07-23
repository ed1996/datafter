class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :add_breadcrumbs_hommages, only: [:show,]
  before_action :add_breadcrumbs_edit_profile, only: [:show]
  before_action :add_breadcrumbs_my_profile, only: [:show]

  def show
    @user = User.friendly.find(params[:id])
  end

  def update_avatar
    @user = User.friendly.find(current_user.id)
    if params[:images]
      @user.avatar = :images
    else
      drop_attached_file :users, :avatar
    end
      respond_to do |format|
        format.json { render json: @user }
      end
  end

  private
  def set_user
    @message = User.friendly.find(params[:id])
  end

end
