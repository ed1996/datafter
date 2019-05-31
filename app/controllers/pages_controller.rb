class PagesController < ApplicationController

  def home
      @hommages = Hommage.limit(4)
  end

end
