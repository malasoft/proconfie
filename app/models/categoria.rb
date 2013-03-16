class Categoria < ActiveRecord::Base

  self.primary_key = 'categoria_id'
  
  has_many :empresas
  has_many :reclamacoes

  attr_accessible :categoria_id, :descricao
  
  # Categoria.search
  def self.search(query)
    categorias = []
    unless query.empty?
      q = "%#{query}%"
      categorias = self.where("descricao like ?", q).limit(10)
    end
    categorias
  end
end
