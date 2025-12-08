class EmailParseLogController < ApplicationController
  def index
    @email_parse_logs = EmailParseLog.order(created_at: :desc).page(params[:page]).per(params[:per_page] || 10)
  end

  def show
    @email_parse_log = EmailParseLog.find(params[:id])
  end
end
