#!/bin/env ruby
# encoding: utf-8

class Empresa < ActiveRecord::Base

  self.primary_key = 'cnpj'
  
  belongs_to :radical_cnpj
  belongs_to :categoria
  has_many :reclamacoes
  has_many :problemas, :through => :reclamacoes
  belongs_to :estado

  attr_accessible :cnpj, :categoria_id, :radical_cnpj_id, :razao_social, :nome_fantasia,
                  :reclamacoes_menos_infinito_ate_tres_anos,
                  :reclamacoes_dois_anos_ate_tres_anos,
                  :reclamacoes_um_ano_ate_dois_anos,
                  :reclamacoes_seis_meses_ate_um_ano,
                  :reclamacoes_hoje_ate_seis_meses,
                  :percentual_reclamacoes_categoria_menos_infinito_ate_tres_anos,
                  :percentual_reclamacoes_categoria_dois_anos_ate_tres_anos,
                  :percentual_reclamacoes_categoria_um_ano_ate_dois_anos,
                  :percentual_reclamacoes_categoria_seis_meses_ate_um_ano, 
                  :percentual_reclamacoes_categoria_hoje_ate_seis_meses,
                  :slope_pedro,
                  :numero_normalizado_reclamacoes_categoria,
                  :mediana_duracao_reclamacoes,
                  :media_duracao_reclamacoes,
                  :skewness_duracao_reclamacoes,
                  :data_primeira_reclamacao,
                  :total_reclamacoes_resolvidas,
                  :numero_proporcional_reclamacoes_res_hoje_ate_seis_meses,
                  :numero_proporcional_reclamacoes_res_seis_meses_ate_um_ano,
                  :numero_proporcional_reclamacoes_res_um_ano_ate_dois_anos,
                  :numero_proporcional_reclamacoes_res_dois_anos_ate_tres_anos,
                  :slope_pes,
                  :score,
                  :estado_id
                  
  TIMESTAMPS = %w{2009-01 2010-01 2011-01 2011-06 2011-12}

  # To be used as empresa.nome (where empresa is an instance of Empresa)
  # Oftenly one of those attributes will be "NULL", but not both
  def nome
    nome = self.nome_fantasia
    nome = self.razao_social if nome == "NULL"
    nome
  end
  
  def ranking(estado)
    empresas = find_other_empresas_within_same_category(estado)
    empresas.index(self) + 1
  end
    
  # To be used as Empresa.search
  def self.search(query, estado)
    empresas = []
    unless query.empty?
      q = "%#{query}%"
      if estado.sigla == "BR"
        empresas = self.where("razao_social like ? or nome_fantasia like ?", q, q).limit(10)
      else
        empresas = estado.empresas.where("razao_social like ? or nome_fantasia like ?", q, q).limit(10)
      end
    end
    empresas
  end
  
  def find_other_empresas_within_same_category(estado)
    if estado.is_brasil?
      empresas = self.categoria.empresas.order("score DESC")
    else
      empresas = estado.empresas.where("categoria_id = ?", self.categoria.id).order("score DESC")
    end
  end
  
  def json_percentual_reclamacoes_resolvidas
    resolvidas = (self.total_reclamacoes_resolvidas / self.reclamacoes.size.to_f) * 100
    nao_resolvidas = 100 - resolvidas
    # Mostra os valores com apenas um digito significativo
    dados = [{:label => "Resolvidas", :value => Float("%.1g" % resolvidas)}, {:label => "Não resolvidas", :value => Float("%.1g" % nao_resolvidas)}]
    dados.to_json
  end
  
  def json_reclamacoes
    percentuais = [ self.reclamacoes_menos_infinito_ate_tres_anos, self.reclamacoes_dois_anos_ate_tres_anos,
                    self.reclamacoes_um_ano_ate_dois_anos, self.reclamacoes_seis_meses_ate_um_ano,
                    self.reclamacoes_hoje_ate_seis_meses]
    dados = []
    TIMESTAMPS.zip(percentuais).each do |timestamp, percentual|
      dados << {:time => timestamp, :value => percentual}
    end
    dados.to_json
  end
  
  def json_percentual_reclamacoes_categoria
    percentuais = [self.percentual_reclamacoes_categoria_menos_infinito_ate_tres_anos,
                   self.percentual_reclamacoes_categoria_dois_anos_ate_tres_anos,
                   self.percentual_reclamacoes_categoria_um_ano_ate_dois_anos,
                   self.percentual_reclamacoes_categoria_seis_meses_ate_um_ano, 
                   self.percentual_reclamacoes_categoria_hoje_ate_seis_meses]
    dados =[]
    TIMESTAMPS.zip(percentuais).each do |timestamp, percentual|
      dados << {:time => timestamp, :value => percentual * 100}
    end
    dados.to_json
  end
  
  def json_numero_proporcional_reclamacoes_resolvidas
    numeros = [self.numero_proporcional_reclamacoes_res_dois_anos_ate_tres_anos,
               self.numero_proporcional_reclamacoes_res_um_ano_ate_dois_anos,
               self.numero_proporcional_reclamacoes_res_seis_meses_ate_um_ano,
               self.numero_proporcional_reclamacoes_res_hoje_ate_seis_meses]
    dados =[]
    TIMESTAMPS[1..-1].zip(numeros).each do |timestamp, numero|
      dados << {:time => timestamp, :value => numero * 100}
    end
    dados.to_json
  end
  
  def json_problemas
    frequencias = Hash.new(0)
    self.problemas.each { |problema| frequencias[problema.descricao] += 1 }
    dados = []
    frequencias.sort_by {|k,v| v}.reverse.each do |problema, frequencia|    # ordered by frequency, decreasing
      dados << {:problem => problema, :frequency => frequencia}
    end
    dados.to_json
  end
end
