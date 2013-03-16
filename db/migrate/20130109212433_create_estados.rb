class CreateEstados < ActiveRecord::Migration
  def change
    create_table :estados do |t|
      t.string :sigla
      t.string :nome
      t.references :regiao
      t.timestamps
    end
  end
end
