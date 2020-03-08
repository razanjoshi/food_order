class ProductsController < ApplicationController
  
  def index
    check_isadmin?
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render 'new'
    end
  end

  def show
    
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      redirect_to products_path
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path    
  end

  private

  def check_isadmin?
    return unless !current_user.is_admin
    redirect_to root_path
    flash[:alert] = "You are not authorized to access this page."
  end
  
  def product_params
    params.require(:product).permit(:title, :price, :picture)
  end
end
