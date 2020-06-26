class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new, :show, :edit, :update, :destroy]
  #before_action :set_one_month, only: :index
  # GET /schedules
  # GET /schedules.json
  def index
    @user = User.find(params[:user_id])
    @schedules = @user.schedules
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
  end

  # GET /schedules/1/edit
  def edit
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @user = User.find(params[:user_id])
    @schedule = @user.schedules.build(schedule_params)
    respond_to do |format|
      if @schedule.save
        format.html { redirect_to user_schedules_url }
        format.json { render :show, status: :created, location: @schedule }
        flash[:success] = "予定を新規作成しました"
      else
        format.html { render :new }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
        flash[:danger] = "新規作成に失敗しました"
      end
    end
  end

  # PATCH/PUT /schedules/1
  # PATCH/PUT /schedules/1.json
  def update
    @user = User.find(params[:user_id])
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to user_schedule_url }
        format.json { render :index, status: :ok, location: @schedule }
        flash[:success] = "予定を編集しました"
      else
        format.html { render :edit }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
        flash[:success] = "予定を編集に失敗しました"
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule.destroy
    respond_to do |format|
      format.html { redirect_to user_schedules_url, notice: 'Schedule was successfully destroyed.' }
      format.json { head :no_content }
      flash[:danger] = "削除しました"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    # Only allow a list of trusted parameters through.
    def schedule_params
      params.require(:schedule).permit(:title, :description, :start_time, :end_time, :start_date, :end_date)
    end
end
