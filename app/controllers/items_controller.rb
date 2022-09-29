class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      render json: user.items, include: :user
    else
      items = Item.all
      render json: items, include: :user
    end
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  def create
    item = Item.create!(item_params)
    render json: item, status: 201
  end

  private 
  
  def render_not_found
    render json: {error: "Not Found"}, status: 404
  end

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end

end
