class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    playlist_id = params["tutorial"]["playlist_id"]
    youtube = YoutubeService.new
    playlist_videos = youtube.playlist_info(playlist_id)
    tutorial = Tutorial.new
    playlist_videos.each do |video|
      tutorial.video.create(video.id)
    end
      #add it as a video in that tutorial,tutorial has title description and thumbnail

  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end
end
