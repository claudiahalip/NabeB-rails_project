class CategoriesController < ApplicationController

    def index
      @categories = Category.all
    end 

    def new 
      @category = Category.new
    end 

    def create 
      @category = Category.create(category_params)
      if @category.save 
        redirect_to category_path(@category) 
      else 
        render :new 
      end
    end 

    def show 
      @category = Category.find_by(id: params[:id])
    end 

    def edit 
        @category = Category.find_id(id: params[:id])
    end 

    def update 
        @category = Category.find_id(id: params[:id])
        @category.update 
        redirect_to category_path(@category)
    end 

    def destroy 
        @category = Category.find_id(id: params[:id])
        @category.destroy 
        redirect_to categories_path
    end 

    private 
    def category_params
       params.require(:category).permit(:name)
    end 
end
