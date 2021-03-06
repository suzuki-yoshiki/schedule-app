class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  #Rubyのリテラル表記と呼ばれるもの
  $days_of_the_week = %w{日 月 火 水 木 金 土}

  # ページ出力前に1ヶ月分のデータの存在を確認・セットします。
  def set_one_month
    @first_day = params[:date].nil? ?
    #月ごとにデータを取得してきます。
    Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    one_month = [*@first_day..@last_day] # 対象の月の日数を代入します。
    # ユーザーに紐付く一ヶ月分のレコードを検索し取得します。
    @homeworks = @user.homeworks.where(work_on: @first_day..@last_day).order(:work_on)

    unless one_month.count == @homeworks.count # それぞれの件数（日数）が一致するか評価します。
      ActiveRecord::Base.transaction do # トランザクションを開始します。
        # 繰り返し処理により、1ヶ月分の勤怠データを生成します。
        one_month.each { |day| @user.homeworks.create!(work_on: day) }
      end
        @homeworks = @user.homeworks.where(work_on: @first_day..@last_day).order(:work_on)
    end

  rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
    flash[:danger] = "ページ情報の取得に失敗しました、再アクセスしてください。"
    redirect_to root_url
  end
end
