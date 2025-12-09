# frozen_string_literal: true

class CustomerController < ApplicationController
  before_action :authenticate_user!
  def index
    @customers = Customer.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end
end
