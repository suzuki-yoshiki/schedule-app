class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:index, :show, :edit]
  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    if params[:video][:body].blank?
      flash[:danger] = "題名を入力してください"
      redirect_to new_user_video_url and return
    elsif params[:video][:youtube_url].blank?
      flash[:danger] = "URLを記入してください"
      redirect_to new_user_video_url and return
    end
    @video = Video.new(video_params)
    url = params[:video][:youtube_url]
    url = url.last(11)
    @video.youtube_url = url
    respond_to do |format|
      if @video.save
        format.html { redirect_to user_videos_path}
        format.json { redirect_to user_videos_path, status: :created, location: @video }
        flash[:success] = "新しく動画を登録しました"
      else
        format.html { redirect_to new_user_video_path }
        format.json { render json: @video.errors, status: :unprocessable_entity }
        flash[:danger] = "動画の登録に失敗しました"
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    url = params[:video][:youtube_url]
    url = url.last(11)
    @video.youtube_url = url
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to user_videos_path}
        format.json { redirect_to user_videos_path}
        flash[:success] = "更新しました"
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
        flash[:danger] = "更新できませんでした"
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to user_videos_url}
      format.json { head :no_content }
      flash[:danger] = "#{@video.body}を削除しました"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    # Only allow a list of trusted parameters through.
    def video_params
      params.require(:video).permit(:body, :youtube_url)
    end
end
