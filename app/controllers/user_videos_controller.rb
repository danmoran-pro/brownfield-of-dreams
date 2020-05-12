class UserVideosController < ApplicationController
  def new; end

  def create
    if !current_user
      flash[:notice] = 'User must login to bookmark videos.'
    elsif current_user.user_videos.find_by(video_id: u_v_params[:video_id])
      flash[:error] = 'Already in your bookmarks'
    else
      make_user_video
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def make_user_video
    user_id = current_user.id
    user_video = UserVideo.new(u_v_params)
    user_video.update(user_id: user_id)
    user_video.save
    flash[:success] = 'Bookmark added to your dashboard!'
  end

  def u_v_params
    params.permit(:video_id)
  end
end
