require 'sinatra/base'

class Miniblog < Sinatra::Base
  use Rack::MethodOverride

  POSTS = ["BLALALAAHAHHHA"]

  get '/' do
    if POSTS.empty?
      'No posts'
    else
      erb :root, locals: {posts: POSTS} 
    end
  end

  get '/new' do
    erb :new
  end

  post '/new' do
    POSTS << params[:description]
    erb :new
  end

  get '/:id' do |id|
    if id.to_i > 0
      erb :id, locals: {post: POSTS[id.to_i-1]}
    else
      'No post with such id.'
    end
  end

  get '/:id/delete' do |id|
    post = id.to_i > 0 ? POSTS[id.to_i-1] : nil
    erb :delete, locals: {post: post, id: id}
  end

  delete '/:id' do |id|
    if id.to_i > 0 and not POSTS[id.to_i-1].nil?
      POSTS[id.to_i-1] = nil
      redirect '/'
    else
      'No post with such id.'
    end   
  end

  run! if app_file == $0
end
