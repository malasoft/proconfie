class Idade < ActiveRecord::Base

  has_many :reclamacoes

  attr_accessible :faixa
end
