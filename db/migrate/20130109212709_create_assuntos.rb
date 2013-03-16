class CreateAssuntos < ActiveRecord::Migration
  def change
    create_table :assuntos, :primary_key => 'assunto_id' do |t|
      t.integer :assunto_id, :null => false
      t.text :descricao
      t.timestamps
    end
  end
end
