class RadicalCnpj < ActiveRecord::Base

  self.primary_key = 'radical_cnpj_id'
  has_many :empresas
  has_many :reclamacoes

  attr_accessible :radical_cnpj_id, :descricao
end
