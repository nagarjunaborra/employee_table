class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.order(params[:sort])
	  if params.has_key?(:where) and params[:where]=='retirement'
       @users =User.where("age >60")
	    elsif params.has_key?(:order) and params[:order]=='highest salary'
      @users =User.order("salary desc").first(1)
	  elsif params.has_key?(:order) and params[:order]=='Top 5 Employees Based on Salary'
      @users =User.order("salary desc").first(5)
	  elsif params.has_key?(:order) and params[:order]=='Top salaried Employees Based on Department'
      @users =User.order("salary desc").group("department")
	  elsif params.has_key?(:order) and params[:order]=='Top 5 Senior most employees by age'
      @users =User.order("age asc").last(5)
	  elsif params.has_key?(:order) and params[:order]=='lowest salary but senior most in the company'
      @users =User.order("age desc").first(1)
	  
	  

	  end

  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to action: :index, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :age, :salary, :department)
    end
end
