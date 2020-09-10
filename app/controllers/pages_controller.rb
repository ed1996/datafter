class PagesController < ApplicationController

  before_action :add_breadcrumbs_services, only: [:contact]
  before_action :add_breadcrumbs_contact, only: [:contact]

  def home
      @hommages = Hommage.limit(4).order('id DESC')
      @animals = Animal.limit(4).order('id DESC')
      @contact = Contact.new
  end

  def robots
    # Don't forget to delete /public/robots.txt
    respond_to :text
  end

  def legal

  end

  def politique

  end

  def services
   # add_breadcrumbs_contact
    add_breadcrumbs_services
  end
end
