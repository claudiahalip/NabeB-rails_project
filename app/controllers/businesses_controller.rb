class BusinessesController < ApplicationController
    def index
      @businesses = Business.all
    end 

    def new 
      @business = Business.new
    end 

    def create 
      @business = Business.create(business_params)
    end 

    def show 
      @business = Business.find_by(id: params[:id])
    end 

    def edit 

    end 

    def update 

    end 

    def destroy 

    end 

    private

    def business_params
      params.require(:business).permit(:name, :descriprion, :website, :phone_number)
    end 
end
