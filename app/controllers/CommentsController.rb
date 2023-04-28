class CommentsController < ApplicationController
    def create
        @project = Project.find(params[:project_id])
        @comment = @project.comments.build(comment_params)
        
        if @comment.save
          redirect_to @project, notice: "Comment was successfully created."
        end
      end
  
    private
    def comment_params
      params.require(:comment).permit(:content)
    end
  end