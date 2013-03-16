class CreateIdades < ActiveRecord::Migration
  def change
    create_table :idades do |t|
      t.string :faixa
      t.timestamps
    end
  end
end
