class PublicationsController < ApplicationController
  #load_and_authorize_resource
  before_action :authenticate_user!, only: [:create, :new]
  # before_action :validate_user, except: [:show, :index]
  before_action :set_publication, except: [:index, :new, :create]
  before_action :set_forum
  # before_action :authenticate_mod!, only: [:destroy]
  # get /articles
  def index
    @publications = Publication.all  # Article es el modelo y all permite traer todos los registros de la tabla
  end
  # get /articles/:id
  def show  # encuentra un registro por su id
    @publication = Publication.find(params[:id])  # params es un hash
    @publication.update_visits_count
    @comment = Comment.new
  end
  # get /articles/new
  def new
    @publication = Publication.new  # creamos un nuevo articulo
  end

  def edit
    @publication = Publication.find(params[:id])
  end

  # post /articles
  def create
    # @publication = Publication.new(title: params[:publication][:title], body: params[:publication][:body])
    # @publication = Publication.new(publication_params)  # como hicimos def article_params lo colocamos aquí
    # @publication.user_id = current_user.id
    @publication = current_user.publications.new(publication_params)
    @publication.forum = @forum
    respond_to do |format|
      if @publication.save
        format.html { redirect_to @publication.forum, notice: 'Publication was successfully created.' }
      else
        render :new  # si no se guardó nos abre la misma vista de new en vez de un error
      end
    end
  end

  def destroy
    @publication = Publication.find(params[:id])
    @publication.destroy
    redirect_to @forum
  end
  # put /articles/:id
  def update
    # @article.update_attributes({title: 'Nuevo título'})
    # @article = Article.find(params[:id])
    if @publication.update(publication_params)
      redirect_to @publication.forum
    else
      render :edit
    end
  end

  def upvote
    @publication = Publication.find(params[:id])
    @publication.upvote_from current_user
    redirect_back(fallback_location: root_path)
    @publication.forum.fixed_visits_count
  end

  def downvote
    @publication = Publication.find(params[:id])
    @publication.downvote_from current_user
    redirect_back(fallback_location: root_path)
    @publication.forum.fixed_visits_count
  end

  private  # todo lo que este bajo private van a ser métodos privados

  # def validate_user
    # redirect_to new_user_session_path, notice: "Necesitas iniciar sesión"
  # end
    def set_publication
      @publication = Publication.find(params[:id])
    end

    def set_forum
      @forum = Forum.find(params[:forum_id])
    end

    def publication_params
      params.require(:publication).permit(:title, :body)  # titulo y cuerpo son permitidos, nada más
    end

    def validate_user
      redirect_to new_user_session_path, notice: "Necesita iniciar sesión"
    end
end
