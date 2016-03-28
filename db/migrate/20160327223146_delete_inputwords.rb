class DeleteInputwords < ActiveRecord::Migration
  def change
  	drop_table :inputwords
  end
end
