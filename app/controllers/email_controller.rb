# frozen_string_literal: true

class EmailController < ApplicationController
  before_action :authenticate_user!

  def new
    @email = Email.new
  end

  def create
    files = params.dig(:email, :files)

    if files.present?
      created_count = create_emails(files)

      if created_count.positive?
        redirect_to emails_path, notice: "#{created_count} email(s) uploaded successfully."
      else
        @email = Email.new
        flash.now[:alert] = 'Failed to upload files.'
        render :new, status: :unprocessable_entity
      end
    else
      @email = Email.new
      flash.now[:alert] = t('email_controller.no_files_selected')
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @emails = Email.order(created_at: :desc).page(params[:page]).per(params[:per_page] || 10)
  end

  def show
    @email = Email.find(params[:id])
  end

  private

  def create_emails(files)
    files = files.reject(&:blank?)

    created_count = 0
    files.each do |file|
      email = Email.new(file: file)
      created_count += 1 if email.save

      ProcessEmailJob.perform_now(email.id)
    end

    created_count
  end
end
