class UsersController < ApplicationController
  before_action :add_breadcrumbs_hommages, only: [:show,]
  before_action :add_breadcrumbs_edit_profile, only: [:show]
  before_action :add_breadcrumbs_my_profile, only: [:show]

  def show
    @user = User.find(params[:id])
  end
end
