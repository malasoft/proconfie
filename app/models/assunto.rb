class Assunto < ActiveRecord::Base
  
  self.primary_key = 'assunto_id'

  has_many :reclamacoes

  attr_accessible :assunto_id, :descricao
end
