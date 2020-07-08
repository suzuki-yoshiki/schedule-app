class HomeworksController < ApplicationController
  before_action :set_homework, only: [:show, :edit_work_info, :update_work_info, :new_homework_info, :update_home_work]
  before_action :set_user, only: [:show, :edit_work_info, :update_work_info, :new_homework_info, :update_home_work]
  before_action :set_one_month, only: [:show, :edit_work_info]

  UPDATE_SUBMISSION_ERROR_MSG = "課題の確認に失敗しました。やり直してください。"
  def index
    @users = User.all
    #@homeworks = @users.homeworks
  end

  def show
    # @user = User.find(params[:user_id])
    # @homework = Homework.find(params[:id])
    @first_day = Date.today.beginning_of_month
    @last_day = @first_day.end_of_month
  end

  def edit_work_info
    @homework = current_user.homeworks.find_by(work_on: params[:date])
    @teacher = User.where(teacher: true).where.not(id: @user.id)
  end

  def update_work_info
    if params[:homework][:teacher_flag].blank?
      flash[:danger] = "提出する教師を選択してください"
      redirect_to @user and return
    elsif params[:homework][:note].blank?
      flash[:danger] = "感想を記入してください"
      redirect_to @user and return
    end
    w1 = 0
    w2 = 0
    w3 = 0
    if params[:homework][:teacher_flag].present?
      if params[:homework][:work_namea] == "1"
        @homework.mark_homeworka = "課題a提出中"
      w1 += 1
      end
      if params[:homework][:work_nameb] == "1"
        @homework.mark_homeworkb = "課題b提出中"
      w2 += 1
      end
      if params[:homework][:work_namec] == "1"
        @homework.mark_homeworkc = "課題c提出中"
      w3 += 1
      end
    end
    @homework.update(homework_params)
    flash[:success] = "#{l(@homework.work_on, format: :short)}の課題を#{w1+w2+w3}つ提出しました"
    redirect_to user_url(current_user) and return
  end

  def new_homework_info
    @users = User.joins(:homeworks).group("users.id").where(homeworks: {check_teacher_answer: "提出中"}).where(homeworks: {teacher_flag: @user.name})
    @homeworks = Homework.where(check_teacher_answer: "提出中")
  end

  def update_home_work
    ActiveRecord::Base.transaction do
      s1 = 0
      s2 = 0
      s3 = 0
      s4 = 0
      s5 = 0
      s6 = 0
      s7 = 0
      s8 = 0
      s9 = 0
      submission_params.each do |id, item|
        if item[:check_teacher_answer].present?
          if (item[:check] == "1") && (item[:check_teacher_answer] == "完了確認" || item[:check_teacher_answer] == "修正確認")
            homework = Homework.find(id)
            if  item[:check_teacher_answer] == "完了確認"
              if item[:work_namea] == "1"
                item[:mark_homeworka] = "課題a完了！"
                homework.edit_mark_homeworka = "a完了"
              s1 += 1
              else item[:work_namea] == "0"
                item[:mark_homeworka] = nil
              end
              if item[:work_nameb] == "1"
                item[:mark_homeworkb] = "課題b完了！"
                homework.edit_mark_homeworkb = "b完了"
              s1 += 1
              else item[:work_nameb] == "0"
                item[:mark_homeworkb] = nil
              end
              if item[:work_namec] == "1"
                item[:mark_homeworkc] = "課題c完了！"
                homework.edit_mark_homeworkc = "c完了"
              s1 += 1
              else item[:work_namec] == "0"
                item[:mark_homeworkc] = nil
              end
            elsif item[:check_teacher_answer] == "修正確認"
              if item[:work_namea] == "1"
                item[:mark_homeworka] = "課題a修正"
                homework.edit_mark_homeworka = "a修正"
              s2 += 1
              else item[:work_namea] == "0"
                item[:mark_homeworka] = nil
              end
              if item[:work_nameb] == "1"
                item[:mark_homeworkb] = "課題b修正"
                homework.edit_mark_homeworkb = "b修正"
              s2 += 1
              else item[:work_nameb] == "0"
                item[:mark_homeworkb] = nil
              end
              if item[:work_namec] == "1"
                item[:mark_homeworkc] = "課題c修正"
                homework.edit_mark_homeworkc = "c修正"
              s2 += 1
              else item[:work_namec] == "0"
                item[:mark_homeworkc] = nil
              end
            end
            item[:check] = "0"
            homework.update(item)
          end
        end
      end
      flash[:success] = "課題確認#{s1}つ、修正確認#{s2}つ各項目に振り分けました"
      redirect_to user_url(current_user) and return
    end
  rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
      flash[:danger] = "UPDATE_SUBMISSION_ERROR_MSG"
      redirect_to user_url(params[:id]) and return
  end

  private

    #ストロングパラメター
    def homework_params
      params.require(:homework).permit(:check_teacher_answer, :work_check, :work_on, :work_namea, :work_nameb, :work_namec, :note, :teacher_flag)
    end

    def submission_params
      params.require(:user).permit(homeworks: [:edit_mark_homeworkc, :edit_mark_homeworkb,:edit_mark_homeworka, :mark_homeworka, :mark_homeworkb, :mark_homeworkc, :check_teacher_answer, :work_on, :work_namea, :work_nameb, :work_namec, :check])[:homeworks]
    end

    
    # beforeフィルター

     # paramsハッシュからユーザーを取得します。
    def set_user
      @user = User.find(params[:user_id])
    end

    def set_homework
      @homework = Homework.find(params[:id])
    end
end
