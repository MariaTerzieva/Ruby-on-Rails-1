require 'sinatra/base'
require './setup.rb'

class Miniblog < Sinatra::Base
  use Rack::MethodOverride

  get '/' do
    posts = DB.execute "select * from posts"
    tags = DB.execute "select * from tags"
    pt = DB.execute "select * from posts_to_tags"
    erb :root, locals: {posts: posts, tags: tags, pt: pt}
  end

  get '/new' do
    erb :new
  end

  post '/new' do
    post = params[:description]
    if post.length > 256
      erb :error
    else 
      DB.execute "insert into posts(body) values('#{post}')"
      post_id = DB.execute "select last_insert_rowid()"
      tags = post.scan(/(?<=\B#)\S+/)
      tags.each do |tag|
        existing_tag = DB.execute "select * from tags where body = '#{tag}'"
        if existing_tag.empty?
          DB.execute "insert into tags(body) values('#{tag}')"
          tag_id = DB.execute "select last_insert_rowid()"
          DB.execute "insert into posts_to_tags(post_id, tag_id) values('#{post_id[0][0]}', '#{tag_id[0][0]}')"
        else
          DB.execute "insert into posts_to_tags(post_id, tag_id) values('#{post_id[0][0]}', '#{existing_tag[0][0]}')"
        end
      end
      erb :new
    end
  end

  get '/:id' do |id|
    post = DB.execute "select body from posts where id = '#{id.to_i}'"
    erb :id, locals: {post: post}
  end

  get '/:id/delete' do |id|
    post = DB.execute "select body from posts where id = '#{id.to_i}'"
    erb :delete, locals: {post: post, id: id.to_i}
  end

  delete '/:id' do |id|
    post = DB.execute "select * from posts where id = '#{id.to_i}'"
    if post.empty?
      'No post with such id.'
    else
      posts_to_tags = DB.execute "select * from posts_to_tags where post_id = '#{id.to_i}'"
      posts_to_tags.each do |pair|
        posts_with_tag = DB.execute "select * from posts_to_tags where tag_id = '#{pair[1]}'"
        if posts_with_tag.count == 1
          DB.execute "delete from tags where id = '#{pair[1]}'"
        end
        DB.execute "delete from posts_to_tags where post_id = '#{pair[0]}' and tag_id = '#{pair[1]}'"
      end
      DB.execute "delete from posts where id = '#{id.to_i}'"
      redirect '/'
    end 
  end

  get '/search/:tag' do |tag|
    tag_id = DB.execute "select id from tags where body = '#{tag}'"
    if tag_id.empty?
      'No post with such tag.'
    else
      post_ids = DB.execute "select post_id from posts_to_tags where tag_id = '#{tag_id[0][0]}'"
      posts = []
      post_ids.flatten.each do |post_id|
        posts << DB.execute("select body from posts where id = '#{post_id}'")[0][0]
      end
      erb :search, locals: {posts: posts}
    end
  end

  run! if app_file == $0
end
