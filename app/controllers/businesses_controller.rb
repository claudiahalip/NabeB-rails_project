class BusinessesController < ApplicationController
  
  
  def index
      if params[:neighborhood_id] && @neighborhood = Neighborhood.find_by_id(params[:neighborhood_id])
        @businesses = @neighborhood.businesses.alpha_sort
      elsif params[:q] && !params[:q].empty?
        @businesses = Business.search_business(params[:q])
      else 
        @businesses = Business.all.alpha_sort
      end
    end 

    def new 
      byebug
      if params[:neighborhood_id] && @neighborhood = Neighborhood.find_by_id(params[:neighborhood_id])
        @business = @neighborhood.businesses.build 

      else
        @business = Business.new
        
      end 
      @business.category_build
      
    end 

    def create 
    
      @business = Business.create(business_params)
      byebug
      if @business.save 
        redirect_to business_path(@business)
      else 
        
        render :new
      end
    end 

    def show 
      @business = Business.find_by(id: params[:id])
    end 

    def edit 
      @business = Business.find_by(id: params[:id])
    end 

    def update 
     @business = Business.find_by(id: params[:id])
     if current_user.id == @business.user_id
        @business.update(business_params)
        redirect_to business_path(@business)
      else
        flash[:message] = "Not yours to change"
        redirect_to businesses_path
      end
    end 

    def destroy 
      business = Business.find(params[:id])
      if current_user.id == business.user_id
        business.destroy
        redirect_to businesses_path
      else
        flash[:message] = "Not yours to delete"
        redirect_to businesses_path
      end 
    end 


    private

    def business_params
      params.require(:business).permit(:name, :description, :website, :phone_number, :neighborhood_id, :user_name, :category_id, category_attributes: [:name])
    end 

    
end
