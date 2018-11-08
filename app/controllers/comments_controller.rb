class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]
  before_action :set_publication
  before_action :set_forum
  before_action :authenticate_user! #, only: [:create, :new]


  # POST /comments
  # POST /comments.json
  def new
    @comment = Comment.new  # creamos un nuevo articulo
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.publication = @publication
    respond_to do |format|
      if @comment.save
        @comment.update_visits_count
        format.html { redirect_to forum_publication_comments_path(@forum, @publication), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  # @comment.publication.forum si funciona
  # forum_publication_path(@forum, @publication) tambien funciona
  # forum_publication_comments_path(@forum, @publication) este es el mejor
  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  # @comment.publication.forum
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to forum_publication_comments_path(@forum, @publication), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to forum_publication_comments_path(@forum, @publication), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @comment = Comment.find(params[:id])
    @comment.upvote_from current_user
    redirect_back(fallback_location: root_path)
  end

  def downvote
    @comment = Comment.find(params[:id])
    @comment.downvote_from current_user
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_publication
      @publication = Publication.find(params[:publication_id])
    end

    def set_forum
      @forum = Forum.find(params[:forum_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :publication_id, :body, :visits_count)
    end
end
