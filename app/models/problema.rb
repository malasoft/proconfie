class Problema < ActiveRecord::Base
  
  self.primary_key = 'problema_id'
  has_many :reclamacoes

  attr_accessible :problema_id, :descricao
end
