class CreateRegioes < ActiveRecord::Migration
  def change
    create_table :regioes do |t|
      t.text :nome
      t.timestamps
    end
  end
end
