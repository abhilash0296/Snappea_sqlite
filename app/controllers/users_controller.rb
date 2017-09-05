class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  
  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end
  
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.json { render json: { notice: "user is successfully created" }, status: :created }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.json { render json: { notice: "user is successfully updated" }, status: :ok }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy    
    respond_to do |format|
      if @user.destroy
        format.json { render json: { notice: "user is successfully destroyed" }, status: :ok }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end      
    end
  end
  
  def login
    @user_data = User.get_login_api user_params[:email],user_params[:password]
    respond_to do |format|
      if @user_data
        format.json { render json: { token: @user_data.api_key }  , status: :ok }
      else
        format.json { render json: { notice: "Invalid Credentials" }, status: :unprocessable_entity }
      end
    end
  end
  
  private
  
  def set_user
    begin
      @user = User.find(params[:id])
    rescue     
      render json: {notice: "user not found"}
    end
  end
  
  def user_params
    begin
      params.require(:user).permit(:name, :email, :password, :encrypted_password)
    rescue Exception => e
      params.permit(:name, :email, :password, :encrypted_password)
    end
  end
  
end
