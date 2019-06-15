class PagesController < ApplicationController

  def home
      @hommages = Hommage.limit(4).order('id DESC')
  end

end
