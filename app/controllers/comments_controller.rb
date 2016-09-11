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
    
    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post)
        
    end
    
    def edit
     @post = Post.find(params[:post_id])   
    end
    
    def update
       @post = Post.find(params[:post_id]) 
       if @post.comments.update(comment_params)
           redirect_to post_path(@post)
       else
           render 'edit'
       end
        
    end
    
    
    
    private
    
    def comment_params
        params.require(:comment).permit(:comment)
    end
    
end
