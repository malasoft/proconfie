class Regiao < ActiveRecord::Base

  has_many :estados
  has_many :reclamacoes
  
  attr_accessible :nome
  
end
