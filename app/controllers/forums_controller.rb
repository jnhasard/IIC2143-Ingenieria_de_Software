class ForumsController < ApplicationController
	# include SpotifyApi
	# before_action :authenticate_user!, only: [:create, :new, :suscribir, :desuscribir]
	# before_action :authenticate_user!, except: [:show, :index]
	before_action :set_forum, except: [:index, :new, :create, :suscribir, :desuscribir, :word_from_title]
	before_action :authenticate_admin!, only: [:new, :create, :update, :destroy]
	# get /articles
	def index
		#@forums = Forum.all  # Article es el modelo y all permite traer todos los registros de la tabla
		#@forums = Forum.where(["title LIKE ?", "%#{params[:search]}%"])
		@forums = Forum.search(params[:search])
	end
	# get /articles/:id
	def show  # encuentra un registro por su id
		# @forum = Article.find(params[:id])  # params es un hash
		@forum.update_visits_count
		@publication = Publication.new
		@pubs = @forum.publications
		@publicaciones_foro = @pubs
		@publicaciones_foro = Publication.search(@forum, params[:search])
	end
	# get /articles/new
	def new
		@forum = Forum.new  # creamos un nuevo articulo
	end

	def edit
		# @article = Article.find(params[:id])
	end

	# post /articles
	def create
		@forum = Forum.new(title: params[:forum][:title], body: params[:forum][:body])
		# @article = Article.new(article_params)  # como hicimos def article_params lo colocamos aquí
		# @forum = current_user.forums.new(forum_params)
		if @forum.save
			redirect_to @forum
		else
			render :new  # si no se guardó nos abre la misma vista de new en vez de un error
		end
	end
	def destroy
		# @article = Article.find(params[:id])
		@forum.destroy
		redirect_to forums_path
	end
	# put /articles/:id
	def update
		# @article.update_attributes({title: 'Nuevo título'})
		# @article = Article.find(params[:id])
		if @forum.update(forum_params)
			redirect_to @forum
		else
			render :edit
		end
	end

	def suscribir
		user = User.find(current_user.id)
     	@event = Forum.find(params[:forum])
     	if user.forums.exclude? @event
     		user.forums << @event
     	end
     	user.save
	end
	
	def desuscribir
		user = User.find(current_user.id)
     	@event = Forum.find(params[:forum])
     	user.forums.delete(@event)
	end

	private  # todo lo que este bajo private van a ser métodos privados

	# def validate_user
		# redirect_to new_user_session_path, notice: "Necesitas iniciar sesión"
	# end
	def set_forum
		@forum = Forum.find(params[:id])
	end

	def forum_params
		params.require(:forum).permit(:title, :body)  # titulo y cuerpo son permitidos, nada más
	end
end