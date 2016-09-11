class CommentsController < ApplicationController
    
    def new
        @post = Post.find(params[:post_id])
        @comment = @post.comments.new
    end
    
    
    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create(comment_params)
         @comment.user_id = current_user.id if current_user
         @comment.save
        if @comment.save
           redirect_to post_path(@post)
        else
            render 'new'
        end
    end
    
    
    
    private
    
    def comment_params
        params.require(:comment).permit(:comment)
    end
    
end
