class CatsController < ApplicationController
  before_action :require_log_in, only: [:new, :create, :edit, :update]
  before_action :require_owns_cat, only: [:edit, :update]
  helper_method :owner_of_cat

  def owner_of_cat
    return false if current_user.nil?
    !!(current_user.cats.find_by(id: params[:id]))
  end


  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  def require_owns_cat
    redirect_to cats_url unless current_user.cats.find_by(id: params[:id])
  end
  private

  def cat_params
    params.require(:cat).permit(:age, :birth_date, :color, :description, :name, :sex)
  end
end
