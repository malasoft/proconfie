class CreateCategoria < ActiveRecord::Migration
  def change
    # Custom integer primary key: http://stackoverflow.com/questions/6402189/specify-custom-primary-key-in-migration
    create_table :categorias, :primary_key => 'categoria_id' do |t|
      t.integer :categoria_id, :null => false
      t.text :descricao
      t.timestamps
    end
  end
end
