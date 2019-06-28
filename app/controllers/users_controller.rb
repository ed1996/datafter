class UsersController < ApplicationController
  before_action :add_breadcrumbs_hommages, only: [:show,]
  before_action :add_breadcrumbs_edit_profile, only: [:show]
  before_action :add_breadcrumbs_my_profile, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  def update_avatar
    if params[:images]
      @user.avatar = :images
    else
      @user.avatar_file_name = nil
      @user.avatar_content_type = nil
      @user.avatar_file_size = nil
      @user.avatar_updated_at = Date.now
    end
    if @user.update(hommage_params)
      save_photos
      redirect_to edit_user_path(@user), notice:"Modification enregistrée..."
    else
      render :edit
    end
  end
end
