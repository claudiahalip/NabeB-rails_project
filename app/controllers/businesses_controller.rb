class BusinessesController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :authorize_owner!, only: [:edit, :update, :destroy]

  def index
      @businesses = Business.all.alpha_sort
      @businesses = @neighborhood.businesses.alpha_sort if params[:neighborhood_id] && @neighborhood = Neighborhood.find_by(id: params[:neighborhood_id])
      @businesses = Business.search_business(params[:q]) if  params[:q] && !params[:q].empty?

      respond_to do |format|
        format.html do
          if request.xhr?
            render partial: 'businesses_list', layout: false
          else
            render :index
          end
        end
        format.json{render json: @businesses}
      end

    end

    def new
      if params[:neighborhood_id] && @neighborhood = Neighborhood.find_by(id: params[:neighborhood_id])
        @business = @neighborhood.businesses.build
      else
        @business = Business.new
      end
      @business.build_category

    end

    def create
      @business = current_user.businesses.build(business_params)

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
    end

    def update
      if @business.update(business_params)
        redirect_to business_path(@business)
      else
        render :edit
      end
    end

    def destroy
      @business.destroy
      redirect_to businesses_path
    end


    private

    def authorize_owner!
      @business = Business.find_by(id: params[:id])
      unless @business && @business.user == current_user
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to businesses_path
      end
    end

    def business_params
      params.require(:business).permit(:name, :description, :website, :phone_number, :neighborhood_id, :category_id, category_attributes: [:name])
    end


end
