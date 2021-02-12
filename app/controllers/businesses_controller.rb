class BusinessesController < ApplicationController
  
  
    def index
      @businesses = Business.all.alpha_sort
      @businesses = @neighborhood.businesses.alpha_sort if params[:neighborhood_id] && @neighborhood = Neighborhood.find_by_id(params[:neighborhood_id])
      @businesses = Business.search_business(params[:q]) if  params[:q] && !params[:q].empty?
      
      respond_to do |format|
        format.html{render :index}
        format.json{render json: @businesses}
      end 
        
    end 

    def new 
      if params[:neighborhood_id] && @neighborhood = Neighborhood.find_by_id(params[:neighborhood_id])
        @business = @neighborhood.businesses.build 
      else
        @business = Business.new
      end 
      @business.build_category
      
    end 

    def create 
      
      @business = Business.create(business_params)
  
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
      # raise params.inspect
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
