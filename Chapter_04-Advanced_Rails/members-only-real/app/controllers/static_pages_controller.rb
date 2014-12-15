class StaticPagesController < ApplicationController
  def index
  	@posts = Post.all
  end
end
