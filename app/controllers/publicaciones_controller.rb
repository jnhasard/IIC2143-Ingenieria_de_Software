class PublicacionesController < ApplicationController
  def index
    @publicacions = Publicacion.all
  end

  def show
    @publicacion = Publicacion.find(params[:id])
  end

  def new
    @publicacion = Publicacion.new  #no se aguarda en la base de datos
  end

  def edit
    @publicacion = Publicacion.find(params[:id])
  end

  def create
    @publicacion = Publicacion.new(publicacion_params)

    if @publicacion.save
      redirect_to @publicacion
    else
      render 'new'
    end
  end

  def update
    @publicacion = Publicacion.find(params[:id])

    if @publicacion.update(publicacion_params)
      redirect_to @publicacion
    else
      render 'edit'
    end
  end

  private
    def publicacion_params
      params.require(:publicacion).permit(:title, :text)
    end
end