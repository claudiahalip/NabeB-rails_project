class NeighborhoodsController < ApplicationController

    def index
      if params[:q] && !params[:q].empty?
        @neighborhoods = Neighborhood.search_neighborhood(params[:q])
      else 
        @neighborhoods = Neighborhood.all.alpha_sort
        
      end
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
   

    private 

    def neighborhood_params
      params.require(:neighborhood).permit(:name,:city, :state, :zipcode )
    end 
end
