class NeighborhoodsController < ApplicationController

    def index

    end 

    def new 

    end 

    def create 

    end 

    def show 

    end 

    def edit 

    end 

    def update 

    end 

    def destroy 

    end 

    private 
    def neighborhood_params
       params.require(:neighborhood).permit(:name,:city, :state, :zipcode )
    end 
end
