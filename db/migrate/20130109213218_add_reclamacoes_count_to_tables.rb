class AddReclamacoesCountToTables < ActiveRecord::Migration
  def change
    add_column :regioes, :reclamacoes_count, :integer, :default => 0, :null => false
    add_column :empresas, :reclamacoes_count, :integer, :default => 0, :null => false
    add_column :categorias, :reclamacoes_count, :integer, :default => 0, :null => false
    add_column :estados, :reclamacoes_count, :integer, :default => 0, :null => false
    add_column :radical_cnpjs, :reclamacoes_count, :integer, :default => 0, :null => false
    add_column :assuntos, :reclamacoes_count, :integer, :default => 0, :null => false
    add_column :problemas, :reclamacoes_count, :integer, :default => 0, :null => false
    add_column :idades, :reclamacoes_count, :integer, :default => 0, :null => false
  end
end
