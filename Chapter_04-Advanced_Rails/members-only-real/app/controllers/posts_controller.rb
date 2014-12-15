class PostsController < ApplicationController
	before_action :logged_in_user, only: [:new, :create]

	def index
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		if @post.save
			flash[:success] = "Post saved"
			redirect_to root_path
		else
			render :new
		end
	end

	private

		def post_params
			params.require(:post).permit(:content, :user_id)
		end

		def logged_in_user
			unless logged_in?
				flash[:danger] = "Please log in"
				redirect_to login_url
			end
		end
end
