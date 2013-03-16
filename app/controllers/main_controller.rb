class MainController < ApplicationController

  def index
  end
  
  def search
  end
  
  def autocomplete
    @empresas = Empresa.search(params[:term], @sigla_session.estado)
    @categorias = Categoria.search(params[:term])
    items =[]
    @empresas.each do |empresa|
      # :url => "http://proconfie.vod.dcc.ufmg.br/empresas/#{empresa.id}",
      items << {:label => empresa.nome, :tipo => "empresas", :id => empresa.id} 
    end
    @categorias.each do |categoria|
      items << {:label => categoria.descricao, :tipo => "categorias", :id => categoria.id} 
    end
    render :json => items.to_json
  end
end
