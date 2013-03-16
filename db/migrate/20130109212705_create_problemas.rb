class CreateProblemas < ActiveRecord::Migration
  def change
    create_table :problemas, :primary_key => 'problema_id' do |t|
      t.integer :problema_id, :null => false
      t.text :descricao
      t.timestamps
    end
  end
end
