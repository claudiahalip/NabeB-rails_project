class BusinessesController < ApplicationController
  
  
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

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
      if params[:neighborhood_id] && @neighborhood = Neighborhood.find_by_id(params[:neighborhood_id])
        @business = @business.build_neighborhood
        
        
  #@neighborhood.businesses.build
      else
        @business = Business.new
        #byebug
        @business.build_category
      end 
      
    end 

    def create 
    
      @business = Business.create(business_params)
      #byebug
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
      @business.update(business_params)
      redirect_to business_path(@business)
    end 

    def destroy 
      business = Business.find(params[:id])
      business.destroy
      redirect_to businesses_path
    end 

    def handle_record_not_found
      render :index 
    end

    private

    def business_params
      params.require(:business).permit(:name, :description, :website, :phone_number, :neighborhood_id, :category_name, :user_name)
    end 

    
end
