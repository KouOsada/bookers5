class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
  end

  def index
    @users = User.all
    @book = Book.new
  end
  
  def create
  end

  def edit
  end
  
  def update
  end
  
end
