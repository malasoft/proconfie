class Estado < ActiveRecord::Base

  belongs_to :regiao
  has_many :reclamacoes
  has_many :empresas

  attr_accessible :sigla, :nome, :regiao_id
  
  def is_brasil?
    self.sigla == "BR"
  end
  
end
