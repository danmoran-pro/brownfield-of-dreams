class Admin::ImportController < Admin::BaseController

  def new
    @tutorial = Tutorial.new
  end
  
end
