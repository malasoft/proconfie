class CreateRadicalCnpjs < ActiveRecord::Migration
  def change
    # Custom integer primary key: http://stackoverflow.com/questions/6402189/specify-custom-primary-key-in-migration
    create_table :radical_cnpjs, :id => false do |t|
      t.string :radical_cnpj_id, :null => false
      t.text :descricao
      t.timestamps
    end
    add_index :radical_cnpjs, :radical_cnpj_id, :unique => true
  end
end
