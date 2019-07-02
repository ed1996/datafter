class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  add_breadcrumb "Datafter", :root_path

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:last_name, :first_name, :date_birth, :avatar, :phone_number, :description, :email, :password, :password_confirmation])
  end

  before_action :set_search

  def set_search
    @q = Hommage.ransack(params[:q])
    @hommages = @q.result(distinct: true)
  end

  private

  ###    BREADCRUMBS
  ###### Hommages
  def add_breadcrumbs_hommages
    if defined? (current_user) and defined?(current_user.id)
      add_breadcrumb "Mes hommages", :hommages_path
    end
  end

  def add_breadcrumbs_list_hommages
    add_breadcrumb "Hommages", :list_hommages_path
  end

  def add_breadcrumbs_detail_hommage
    if @hommage.id
      add_breadcrumb "Detail " + @hommage.first_name + " " + @hommage.last_name, hommage_path(@hommage)
    end
  end

  def add_breadcrumbs_edit_hommage
    if current_user.id = @hommage.user_id and @hommage.id
      add_breadcrumb "Edition " + @hommage.first_name + " " + @hommage.last_name
    end
  end

  ###### Message
  def add_breadcrumbs_messages
    if defined? (current_user) and defined?(current_user.id)
      add_breadcrumb "Mes messages", :messages_path
    end
  end

  def add_breadcrumbs_detail_message
    if @message.id
      add_breadcrumb "Detail " + @message.object, message_path(@message)
    end
  end

  def add_breadcrumbs_edit_message
    if current_user.id = @message.user_id and @message.id
      add_breadcrumb "Edition " + @message.object
    end
  end

  ###### Memoire
  def add_breadcrumbs_memories
    if defined? (current_user) and defined? (current_user.id)
      add_breadcrumb "Mes mémoires", :memory_path
    end
  end

  ###### Profile
  def add_breadcrumbs_edit_profile
    add_breadcrumb "Modifier mon profil", edit_user_registration_path
  end

  def add_breadcrumbs_my_profile
    add_breadcrumb "Mon profil", user_path(current_user.id)
  end


  ###### Divers
  def add_breadcrumbs_contact
    add_breadcrumb "Contactez nous", "/contact"
  end

  def add_breadcrumbs_services
    add_breadcrumb "Nos services", "/services"
  end

  def require_subscribed!
    if current_user.subscribed != true
      flash[:danger] = "Vous n'avez pas le droit de modifier cette page"
      redirect_to subscribers_path
    end
  end

  def require_same_user (resource)
    if current_user.id != resource.user_id
      flash[:danger] = "Vous n'avez pas le droit de modifier cette page"
      redirect_to root_path
    end
  end

  def not_search
    if params.has_key?(:q) && params.has_key?(:commit)
      @notSearch = true
    end
  end
end
