class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
    	t.string :words

     	t.timestamps null: false
    end

  end
end
