# frozen_string_literal: true

class EmailParseLogController < ApplicationController
  before_action :authenticate_user!
  def index
    @email_parse_logs = EmailParseLog.includes(:email)
                                     .order(created_at: :desc)
                                     .page(params[:page])
                                     .per(params[:per_page] || 10)
  end

  def show
    @email_parse_log = EmailParseLog.find(params[:id])
  end

  def destroy_all
    EmailParseLog.destroy_all
    redirect_to email_parse_logs_index_url, notice: t('email_parse_log_controller.destroy_all.success')
  end
end
