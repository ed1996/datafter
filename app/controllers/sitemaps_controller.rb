class SitemapsController < ApplicationController

  layout :false
  before_action :init_sitemap

  def index
    @hommages = Hommage.all
  end

  private

  def init_sitemap
    headers['Content-Type'] = 'application/xml'
  end

end
