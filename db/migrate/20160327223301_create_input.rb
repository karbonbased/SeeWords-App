class CreateInput < ActiveRecord::Migration
  def change
    create_table :inputs do |t|
    	t.string :word

      t.timestamps null: false
    end
  end
end
