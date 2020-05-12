class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
    @videos = @facade.videos.paginate(:page => params[:page], per_page: 10)
  end
end
