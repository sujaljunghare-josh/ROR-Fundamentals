class CommentsController < ApplicationController
    before_action :set_blog
  
    def create
      # Use the association to build the comment
      @comment = @blog.comments.build(comment_params)
  
      if @comment.save
        redirect_to @blog, notice: "Comment was successfully added."
      else
        # If validation fails (e.g., blog isn't published), show the error
        redirect_to @blog, alert: @comment.errors.full_messages.to_sentence
      end
    end
  
    private
  
    def set_blog
      # In nested routes, the parent ID is passed as :blog_id
      @blog = Blog.find(params[:blog_id])
    end
  
    def comment_params
      params.require(:comment).permit(:body)
    end
  end