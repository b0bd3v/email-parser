# frozen_string_literal: true

# Controller for managing emails.
class EmailController < ApplicationController
  before_action :authenticate_user!

  def new
    @email = Email.new
  end

  def create
    files = params.dig(:email, :files)

    if files.present?
      # Reject blank strings which sometimes come with file inputs
      files = files.reject(&:blank?)

      created_count = 0
      files.each do |file|
        email = Email.new(file: file)
        created_count += 1 if email.save
      end

      if created_count.positive?
        redirect_to emails_path, status: :created, notice: "#{created_count} email(s) uploaded successfully."
      else
        @email = Email.new
        flash.now[:alert] = 'Failed to upload files.'
        render :new, status: :unprocessable_entity
      end
    else
      @email = Email.new
      flash.now[:alert] = 'No files selected.'
      render :new, status: :unprocessable_entity
    end
  end

  def index; end

  def show
    @email = Email.find(params[:id])
  end
end
