class NeighborhoodsController < ApplicationController

    def index
      @neighborhoods = Neighborhood.all
    end 

    def new 
      @neighborhood = Neighborhood.new
    end 

    def create 
      @neighborhood = Neighborhood.create(neighborhood_params)
      if @neighborhood.save
        redirect_to neighborhood_path(@neighborhood)
      else 
        render :new
      end
    end 

    def show 
      @neighborhood = Neighborhood.find_by(id: params[:id])
    end 

    def edit 
      @neighborhood = Neighborhood.find_by(id: params[:id])
    end 

    def update 
      @neighborhood = Neighborhood.find_by(id: params[:id])
      @neighborhood.update(neighborhood_params)
      redirect_to neighborhood_path(@neighborhood)
    end 

    def destroy 
      neighborhood = Neighborhood.find_by(id: params[:id])
      neighborhood.destroy
      redirect_to neighborhoods_path
    end 

    private 

    def neighborhood_params
      params.require(:neighborhood).permit(:name,:city, :state, :zipcode )
    end 
end
