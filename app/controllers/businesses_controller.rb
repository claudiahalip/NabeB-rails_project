class BusinessesController < ApplicationController
    def index
      @businesses = Business.all
    end 

    def new 
      @business = Business.new
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
      @business = Business.find_id(id: params[:id])
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

    private

    def business_params
      params.require(:business).permit(:name, :description, :website, :phone_number)
    end 
end
