class PostsphotosController < ApplicationController

  def index
    @posts = Post.all
    @photos = Photo.all
  end

end
