class CategoriesController < ApplicationController
  def index
    render json: Category.all
  end

  def show
    category = Category.find_by(id: params[:id])
    if category
      render json: category
    else
      render json: category.errors, status: :not_found
    end
  end

  def create
    category = Category.create(name: params[:name])
    if category.valid?
      render json: category, location: category_url(category), status: :created
    else
      render json: category.errors
    end
  end

  def destroy
    render json: Category.find(params[:id]).destroy
  end

  def update
    category = Category.find_by(id: params[:id])
    if category.update(name: params[:name])
      render json: category
    else
      render json: category.errors
    end
  end

  def count
    render json: Category.all.count
  end

  def range
    unless Category.find_by(id: params[:from])
      render json: { "error": "not-found" }.to_json, status: :not_found
    end
    if params[:count]
      render json: Category.where("id >= ? and id < ?", params[:from], params[:from].to_i+params[:count].to_i)
    else
      render json: Category.where("id > ?", params[:from])
    end
  end
end