class BusinessesController < ApplicationController
    def index
      @businesses = Business.all
    end 

    def new 
      @business = Business.new
    end 

    def create 
      
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
end
