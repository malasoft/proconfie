class CategoriasController < ApplicationController
  def show
    @categoria = Categoria.find(params[:id])
    estado = sigla_session.estado
    if estado.is_brasil?
      @empresas = @categoria.empresas.order("score DESC")
    else
      @empresas = estado.empresas.where("categoria_id = ?", @categoria.id).order("score DESC")
    end
  end
end
