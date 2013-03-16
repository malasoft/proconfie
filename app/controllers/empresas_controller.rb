class EmpresasController < ApplicationController
  def show
    @empresa = Empresa.find(params[:id])
    @percentual_reclamacoes_resolvidas = @empresa.json_percentual_reclamacoes_resolvidas
    @reclamacoes = @empresa.json_reclamacoes
    @percentual_reclamacoes_categoria = @empresa.json_percentual_reclamacoes_categoria
    @proporcional_reclamacoes_resolvidas = @empresa.json_numero_proporcional_reclamacoes_resolvidas
    @problemas = @empresa.json_problemas
    @empresas_with_same_category = @empresa.find_other_empresas_within_same_category(sigla_session.estado)
  end
end
