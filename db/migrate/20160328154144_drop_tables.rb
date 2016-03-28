class DropTables < ActiveRecord::Migration
  def change
  	drop_table :results 
  	drop_table :words
  end
end
