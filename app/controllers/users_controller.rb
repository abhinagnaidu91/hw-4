class UsersController < ApplicationController  
  def show
    @user = User.find_by({ "id" => params["id"] })
  end
  
  def new
  end

  def create
    if User.find_by({ "email" => params["email"] }) == nil
      @user = User.new
      @user["username"] = params["username"]
      @user["email"] = params["email"]
    
      # encrypt user's password before storing in database
      @user["password"] = BCrypt::Password.create(params["password"])
      @user.save
      redirect_to "/login"
    else
      flash["notice"] = "Email already taken. Please use a different email"
      redirect_to "/users/new"
    end
  end
end
