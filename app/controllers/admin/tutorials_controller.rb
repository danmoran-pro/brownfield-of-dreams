class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    youtube = YoutubeService.new
    playlist_videos = youtube.playlist_info(params['tutorial']['playlist_id'])
    tutorial = Tutorial.create(grab_tutorial_params)
    if !playlist_videos.nil?
      playlist_videos.each do |video|
        vid = youtube.video_info(video[:contentDetails][:videoId])
        add_video(vid, tutorial)
      end
    end
    tutorial_saved?(tutorial)
    redirect_to admin_dashboard_path
  end

  def add_video(video, tutorial)
    params = grab_video_params(video)
    video = tutorial.videos.new(params)
    video.save
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

  def grab_video_params(video)
    info_hash = video[:items].first[:snippet]
    vid_params = { title: info_hash[:title],
                   description: info_hash[:description],
                   video_id: video[:items].first[:id],
                   thumbnail: info_hash[:thumbnails][:standard] }
    vid_params
  end

  def grab_tutorial_params
    { title: params['tutorial']['title'],
      description: params['tutorial']['description'],
      thumbnail: params['tutorial']['thumbnail'],
      playlist_id: params['tutorial']['playlist_id'] }
  end

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def tutorial_saved?(tutorial)
    if tutorial.save
      link = view_context.link_to('View it here.', tutorial_path(tutorial.id))
      flash[:success] = "Successfully created tutorial. #{link}"
    else
      flash[:error] = "Tutorial not created - #{tutorial.errors.full_messages.to_sentence}"
    end
  end

end
