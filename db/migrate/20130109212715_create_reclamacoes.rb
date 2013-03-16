class CreateReclamacoes < ActiveRecord::Migration
  def change
    create_table :reclamacoes do |t|
      t.integer :ano
      t.datetime :data_cadastro
      t.datetime :data_arquivamento
      t.integer :duracao                          # segundos
      t.references :estado
      t.references :regiao
      t.string :empresa_id                        # empresa_id == cnpj, mas o t.references do Rails define o tipo integer
      t.references :radical_cnpj
      t.references :categoria
      t.references :assunto
      t.references :problema
      t.integer :sexo
      t.references :idade
      t.boolean :resolvido
      t.string :cep
      t.timestamps
    end
  end
end
