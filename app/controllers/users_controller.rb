class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :edit_basic_info, :update_basic_info]
  before_action :set_one_month, only: :show

  def index
    @users = if params[:search]
    User.paginate(page: params[:page], per_page: 20).search(params[:search])
    else
      User.paginate(page: params[:page], per_page: 20)
    end
  end

  def import
    if params[:file].blank?
      flash[:danger] = "CSVファイルが選択されてません"
    elsif File.extname(params[:file].original_filename) != ".csv"
      flash[:danger] = "CSVファイルのみ選択してください"
    else User.import(params[:file])
      flash[:success] = "インポートしました"
    end
    redirect_to users_url
  end

  def show
    @homework_comps = Homework.where(homeworks: {edit_mark_homeworka: "a完了", edit_mark_homeworkb: "b完了", edit_mark_homeworkc: "c完了", teacher_flag: @user.name})
    @homework = @homework_comps.find_by(work_on: params[:date])
    all_work = Homework.all
    @work_sum = all_work.where(check_teacher_answer: "提出中").where(teacher_flag: @user.name).size
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user # 保存成功後、ログインします。
      flash[:success] = "新規作成に成功しました"
      redirect_to @user
      # 保存に成功した場合は、ここに記述した処理が実行されます。
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました"
      redirect_to @user
      # 更新に成功した場合の処理を記述します。
    else
      render :edit      
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

  def edit_basic_info
  end

  def update_basic_info
    if @user.update_attributes(user_params)
      flash[:success] = "#{@user.name}の基本情報を更新しました"
    else
      flash[:danger] = "#{@user.name}の更新に失敗しました <br>" + @user.errors.full_messages.join("<br>")
    end
      redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :category_class, :teacher, :teacher_uid, :student_uid, :password, :password_confirmation)
    end

    # beforeフィルター

     # paramsハッシュからユーザーを取得します。
     def set_user
      @user = User.find(params[:id])
    end

    # ログイン済みのユーザーか確認します。
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
    # アクセスしたユーザーが現在ログインしているユーザーか確認します。
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
    # システム管理権限所有かどうか判定します。
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end
