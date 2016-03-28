class CreateWords < ActiveRecord::Migration
  def change
    create_table :inputwords do |t|
    	t.string :inputwords

      t.timestamps null: false
    end
  end
end
