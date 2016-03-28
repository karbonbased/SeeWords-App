class CreateWordTable < ActiveRecord::Migration
  def change
    create_table :words do |t|
		t.string :inputwords

      	t.timestamps null: false
    end

    drop_table :inputs

  end
end
