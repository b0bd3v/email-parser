class EmailController < ApplicationController
  def new
    @email = Email.new
  end
  
  def create
    @email = Email.new file: params[:email][:file]

    if @email.save
      # TODO: Fazer i8n posteriormente
      redirect_to @email, status: :created, notice: 'Criado com sucesso'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    
  end

  def show
    @email = Email.find(params[:id])
  end
end
