class FixWords < ActiveRecord::Migration
  def change
	drop_table :words
	drop_table :associations

  	 create_table :words do |t|
    	t.string :name

      t.timestamps null: false
    end
  end
end
