# Manages customer-related actions such as listing and showing details.
class CustomerController < ApplicationController
  def index
    @customers = Customer.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end
end
